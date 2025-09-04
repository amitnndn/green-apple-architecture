s = softwareSystem "Green Apple E-Commerce System" {
    !docs docs
    !adrs adrs
    ui = container "E-Commerce UI" "" "ExpressJS" {
        auth = component "Authentication"
        profile = component "Profile Management"
        notifications = component "Notifications"
        order = component "Order Information"

        tags "Amazon Web Services - Elastic Container Kubernetes"
    }
    
    api = container "E-Commerce API" "" "React/NextJS" {
        auth = component "Authentication"
        profile = component "Profile Management"
        notifications = component "Notifications"
        order = component "Order Information"
        promotion = component "Apply Promotions"
        discount = component "Apply Discounts"

        tags "Amazon Web Services - Elastic Container Kubernetes"
    }

    adminui = container "Admin UI" "" "ExpressJS" {
        auth = component "Authentication" "Handles Authentication"
        products = component "Products" "CRUD Operations on products"
        promotions = component "Promotions" "CRUD Operations on promotions"
        discounts = component "Discount" "CRUD operations on discounts"
        configuration = component "Configuration" "Configuration management"

        tags "Amazon Web Services - Elastic Container Kubernetes"
    }

    adminapi = container "Admin API" "" "React/NextJS" {
        auth = component "Authentication" "Handles Authentication"
        products = component "Products" "CRUD Operations on products"
        promotions = component "Promotions" "CRUD Operations on promotions"
        discounts = component "Discount" "CRUD operations on discounts"
        configuration = component "Configuration" "Configuration management"

        tags "Amazon Web Services - Elastic Container Kubernetes"
    }

    database = container "Database" "" "Relational database schema" {
        tags "Amazon Web Services - RDS"
    }

    backend = container "Backend" "" "Spring Boot" {
        shipping = component "Shipping Service" "Handles shipping" "Spring Boot"
        tax = component "Tax Calculation Service" "Applies tax rules" "Spring Boot"
        discount = component "Discount Service" "Handles discount logic" "Spring Boot"
        payment = component "Payment Service" "Handles payments" "Spring Boot"
        report = component "Reports Service" "Generates reports" "Spring Boot"
        promotion = component "Promotion Service" "Handles promotions" "Spring Boot"
        notification = component "Notification Service" "Sends Notifications" "Spring Boot"
        tags "Amazon Web Services - Elastic Container Kubernetes"
    }

    opensearch = container "Elastic Search" "" "Elastic Search" {
        tags "Amazon Web Services - OpenSearch Service"
    }
}

u -> s.ui "Uses"
u -> s.ui.auth "Authenticates"
s.ui.auth -> s.api.auth "Authenticates"

e -> s.adminui "Uses"
e -> s.adminui.auth "Authenticates"
s.adminui.auth -> s.adminapi.auth "Authenticates"

s.api.discount -> s.backend "Apply Discounts"

s.adminui -> s.adminapi "Queries"
s.api -> s.database "Reads from and writes to"
s.ui -> s.api "Queries"
s.api -> s.opensearch "Reads from"
s.api -> s.backend "Submit Jobs"
s.backend -> s.database "Reads from and writes to"
s.backend -> s.opensearch "Writes to"
s.adminapi -> s.database "Reads from and writes to"
s.adminapi -> s.backend "Submit Jobs"


s.api -> s.backend.tax "Calculate Taxes" 
s.api -> s.backend.discount "Apply Coupon Codes" 
s.api.promotion -> s.backend.promotion "Apply Promotions"
s.api -> s.backend.payment "Submit order payment"
s.api -> s.backend.shipping "Submit order shipping"

s.backend.shipping -> shipping-platform "Process Shipping"
s.backend.payment -> payment-platform "Process Payment"
s.backend.notification -> marketing-platform "Send Updates to Users"
s.api -> support-platform "Process Support Requests"
