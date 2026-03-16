# --- GIAI ĐOẠN 1: BUILD ---
FROM maven:3.9.11-eclipse-temurin-25 AS builder

WORKDIR /app

COPY . .

# Biên dịch code thành file .jar
# Bỏ qua test để build nhanh hơn
RUN mvn package -DskipTests


# --- GIAI ĐOẠN 2: RUN ---
FROM eclipse-temurin:25-jre-jammy

WORKDIR /app

# Chỉ lấy file .jar từ giai đoạn build
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

# Lệnh chạy ứng dụng
ENTRYPOINT ["java", "-jar", "app.jar"]