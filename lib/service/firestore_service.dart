import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:memo_todo/features/task/model/category_model.dart';
import 'package:memo_todo/features/task/model/task_model.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> addCategory(CategoryModel data) async {
    try {
      await firestore
          .collection('user')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('category')
          .doc(data.id)
          .set(data.toJson());
    } catch (e) {
      log('Error adding category: $e');
      throw e;
    }
  }

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('user')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('category')
          .get();
      return querySnapshot.docs
          .map((doc) =>
              CategoryModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('Error fetching categories: $e');
      return [];
    }
  }

  Future<void> updateCategory(CategoryModel data) async {
    try {
      await firestore
          .collection('user')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('category')
          .doc(data.id)
          .update(data.toJson());
    } catch (e) {
      log('Error updating category: $e');
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      await firestore
          .collection('user')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('category')
          .doc(id)
          .delete();
    } catch (e) {
      log('Error deleting category: $e');
    }
  }

  Future<void> addTask(TaskModel data) async {
    try {
      await firestore
          .collection('user')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('category')
          .doc(data.categoryId)
          .collection('tasks')
          .doc(data.id)
          .set(data.toJson());
    } catch (e) {
      log('Error adding task: $e');
      throw e;
    }
  }

  Future<List<TaskModel>> getAllTasks(String categoryId) async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('user')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('category')
          .doc(categoryId)
          .collection('tasks')
          .orderBy('date', descending: true)
          .get();
      return querySnapshot.docs
          .map((doc) => TaskModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('Error fetching tasks: $e');
      return [];
    }
  }

  Future<void> updateTask(TaskModel data) async {
    try {
      await firestore
          .collection('user')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('category')
          .doc(data.categoryId)
          .collection('tasks')
          .doc(data.id)
          .update({"isComplete": data.isComplete});
    } catch (e) {
      log('Error updating task: $e');
    }
  }

  Future<void> deleteTask(String categoryId, String id) async {
    try {
      await firestore
          .collection('user')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('category')
          .doc(categoryId)
          .collection('tasks')
          .doc(id)
          .delete();
    } catch (e) {
      log('Error deleting task: $e');
    }
  }
}
