import 'package:asthma/Services/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

supabaseConfig() async {
  await Supabase.initialize(
    url: "https://ozzhqnrsvkxoevghrpse.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im96emhxbnJzdmt4b2V2Z2hycHNlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE2OTM5MzYsImV4cCI6MjAxNzI2OTkzNn0.8hvY_86nq4Jh5nNWDefj9KwAgWPbTXlCxLeKz7a5k8w",
  );
}
