import 'package:flutter/material.dart';
import 'package:memo_todo/constants/colors.dart';
import 'package:memo_todo/features/task/controller/task_controller.dart';
import 'package:memo_todo/features/task/model/category_model.dart';
import 'package:memo_todo/features/task/model/task_model.dart';
import 'package:memo_todo/features/task/view/widgets/add_task_card.dart';
import 'package:memo_todo/utils/get_day_description.dart';
import 'package:memo_todo/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class CategoryTasksScreen extends StatefulWidget {
  final CategoryModel category;

  const CategoryTasksScreen({super.key, required this.category});

  @override
  State<CategoryTasksScreen> createState() => _CategoryTasksScreenState();
}

class _CategoryTasksScreenState extends State<CategoryTasksScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskController>(context, listen: false)
        .fetchTasks(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Row(
          children: [
            CustomText(text: widget.category.icon),
            CustomText(text: widget.category.title),
          ],
        ),
      ),
      body: Consumer<TaskController>(builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final tasks = value.tasks;

        final groupedTasks = <String, List<TaskModel>>{};
        for (var task in tasks) {
          final dateLabel =
              task.date != null ? getDayDescription(task.date!) : 'No Date';
          if (groupedTasks.containsKey(dateLabel)) {
            groupedTasks[dateLabel]!.add(task);
          } else {
            groupedTasks[dateLabel] = [task];
          }
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: groupedTasks.entries.map((entry) {
              final dateLabel = entry.key;
              final tasksForDate = entry.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomText(
                      text: dateLabel,
                      size: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...tasksForDate.map((task) => ListTile(
                        trailing: IconButton(
                            onPressed: () {
                              value.deleteTask(widget.category.id, task.id!);
                            },
                            icon: const Icon(Icons.delete)),
                        leading: InkWell(
                          onTap: () {
                            value.updateTask(TaskModel(
                                categoryId: widget.category.id,
                                id: task.id,
                                task: task.task,
                                date: task.date,
                                isComplete: !task.isComplete!));
                          },
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: greyColor,
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: task.isComplete!
                                  ? Colors.green
                                  : Colors.white,
                              child: task.isComplete!
                                  ? const Icon(
                                      Icons.check,
                                      size: 16,
                                      color: whiteColor,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        title: CustomText(
                          text: task.task ?? '',
                          textAlign: TextAlign.start,
                        ),
                      )),
                ],
              );
            }).toList(),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierColor: Colors.white.withOpacity(.8),
            builder: (BuildContext context) {
              return AddTaskCard(categoryId: widget.category.id);
            },
          );
        },
        backgroundColor: secondaryColor,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: whiteColor,
        ),
      ),
    );
  }
}
