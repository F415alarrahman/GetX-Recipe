import 'package:dio/dio.dart';
import 'package:recipe/app/data/services/auth_service.dart';

class RecipeService {
  final Dio _dio = Dio();

  Future<List> getAllRecipe() async {
    final token = await AuthService().getToken();
    if (token == null) {
      print("Error: No token found");
      return [];
    }

    try {
      final response = await _dio.get(
        'https://recipe.incube.id/api/recipes',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print("[GET ALL RECIPES] Full Response: ${response.data}");

      // ✅ Ambil `data['data']` yang berisi list resep
      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        var extractedData =
            response.data['data']['data']; // 🔥 Ubah ke `data['data']`

        if (extractedData is List) {
          print("[DEBUG] Loaded ${extractedData.length} recipes");
          return extractedData;
        } else {
          print("Error: `data['data']` is not a List - ${response.data}");
          return [];
        }
      } else {
        print("Error: Invalid response format - ${response.data}");
        return [];
      }
    } catch (e) {
      print("Error fetching recipes: $e");
      return [];
    }
  }

  Future<Map<String, dynamic>?> getRecipeById(int id) async {
    final token = await AuthService().getToken();
    if (token == null) {
      print("Error: No token found");
      return null;
    }

    try {
      final response = await _dio.get(
        'https://recipe.incube.id/api/recipes/$id', // 🔥 API endpoint sesuai ID resep
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print("[GET RECIPE] Response: ${response.statusCode} - ${response.data}");

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        var extractedData = response.data['data']; // 🔥 Ambil data yang benar
        return extractedData;
      } else {
        print("Error: Failed to fetch recipe details");
        return null;
      }
    } catch (e) {
      print("Error fetching recipe details: $e");
      return null;
    }
  }

  void _handleDioError(DioException e) {
    print("[DIO ERROR] ${e.message} | Response: ${e.response?.data}");
  }
}
