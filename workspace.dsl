workspace "Green Apple" "Architecture" {
    !identifiers hierarchical
    !docs docs

    model {
        !include people.dsl
        !include external.dsl    
        !include system.dsl
        
        live = deploymentEnvironment "Deployment" {
            deploymentNode "Amazon Web Services" {
                route53 = infrastructureNode "Route 53" {
                    tags "Amazon Web Services - Route 53", "DNS"
                }
                deploymentNode "US-East-1" {
                    elb = infrastructureNode "Elastic Load Balancer" {
                        tags  "Amazon Web Services - Elastic Load Balancing Application Load Balancer"
                    }

                    sns = infrastructureNode "SNS Topics" {
                        tags "Amazon Web Services - Simple Notification Service Topic"
                    }

                    deploymentNode "Amazon EKS" {
                        deploymentNode "EKS Cluster" {
                            apiInstance = containerInstance s.api
                            uiInstance = containerInstance s.ui
                            adminUiInstance = containerInstance s.adminui
                            adminApiInstance = containerInstance s.adminapi
                            backendInstance = containerInstance s.backend
                            tags "Amazon Web Services - Elastic Container Kubernetes"
                            route53 -> elb "Forwards requests to" "HTTPS"  
                            elb -> uiInstance "Forwards requests to" "HTTPS"
                            apiInstance -> sns "Queues Requests"
                            sns -> backendInstance "Queues Requests"
                        }
                        tags "Amazon Web Services - Elastic Kubernetes Service"  
                    }

                    deploymentNode "Elastic Search" {
                        primary = containerInstance s.opensearch
                        secondary = containerInstance s.opensearch
                    }

                    deploymentNode "Amazon RDS" {
                        writerInstance = containerInstance s.database "Writer Instance"
                        readerInstance = containerInstance s.database "Reader Instance"

                        tags "Amazon Web Services - RDS"
                    }
                }
            }
        }
    }

    views {
        deployment s live {
            include *
            autoLayout lr
        }

        systemContext s "Context" {
            include *
            autolayout lr
        }

        container s "Container" {
            include * 
            autolayout lr
        }

        component s.backend "Backend" {
            include *
            autolayout lr
        }

        component s.adminui "AdminUI" {
            include * 
            autolayout lr
        }

        component s.ui "UI" {
            include * 
            autolayout lr
        }

        dynamic s "CheckoutFlow" {

         u -> s.ui "Submit checkout"
         s.ui -> s.api "Submit order"
         s.api -> s.backend "Apply discounts"
         s.api -> s.backend "Apply Promotions"
         s.backend -> payment-platform "Place Hold"
         s.backend -> shipping-platform "Submit Shipping"
         s.backend -> marketing-platform "Send notification"
         s.backend -> s.database "Save information"

         autolayout lr
        }

        dynamic s "CreatePromos" {
            e -> s.adminUi "Create Promotion"
            s.adminUi -> s.adminApi "Create Promotion"
            s.adminApi -> s.database "Save Promotion"

            autolayout lr
        }


        styles {
            element "Element" {
                color #f88728
                stroke #f88728
                strokeWidth 7
                shape roundedbox
            }
            element "Person" {
                shape person
            }
            element "Database" {
                shape cylinder
            }
            element "Boundary" {
                strokeWidth 5
            }
            relationship "Relationship" {
                thickness 4
            }
        }

        theme "https://static.structurizr.com/themes/amazon-web-services-2023.01.31/theme.json"
    }
    
}
