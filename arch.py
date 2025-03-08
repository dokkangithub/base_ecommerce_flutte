#this code to create the project files just save it in base dir as arch.py file and run python3 arch.py



import os

def create_folders(folder_structure, root=""):
    for folder, subfolders in folder_structure.items():
        path = os.path.join(root, folder)
        os.makedirs(path, exist_ok=True)
        if isinstance(subfolders, dict):
            create_folders(subfolders, path)

def main():
    project_structure = {
        "lib": {
            "config": {
                "app_config.dart": None,
                "routes.dart": None,
                "themes.dart": None,
            },
            "core": {
                "api": {
                    "api_provider.dart": None,
                    "laravel_api_provider.dart": None,
                    "wordpress_api_provider.dart": None,
                },
                "errors": {
                    "exceptions.dart": None,
                    "failures.dart": None,
                },
                "network": {
                    "network_info.dart": None,
                    "http_client.dart": None,
                },
                "utils": {
                    "constants.dart": None,
                    "input_validator.dart": None,
                    "logger.dart": None,
                }
            },
            "data": {
                "datasources": {
                    "laravel": {
                        "auth_remote_datasource.dart": None,
                        "product_remote_datasource.dart": None,
                        "order_remote_datasource.dart": None,
                    },
                    "wordpress": {
                        "auth_remote_datasource.dart": None,
                        "product_remote_datasource.dart": None,
                        "order_remote_datasource.dart": None,
                    }
                },
                "models": {
                    "laravel": {
                        "user_model.dart": None,
                        "product_model.dart": None,
                        "order_model.dart": None,
                    },
                    "wordpress": {
                        "user_model.dart": None,
                        "product_model.dart": None,
                        "order_model.dart": None,
                    }
                },
                "repositories": {
                    "auth_repository_impl.dart": None,
                    "product_repository_impl.dart": None,
                    "order_repository_impl.dart": None,
                }
            },
            "domain": {
                "entities": {
                    "user.dart": None,
                    "product.dart": None,
                    "order.dart": None,
                },
                "repositories": {
                    "auth_repository.dart": None,
                    "product_repository.dart": None,
                    "order_repository.dart": None,
                },
                "usecases": {
                    "auth": {
                        "login.dart": None,
                        "register.dart": None,
                    },
                    "products": {
                        "get_products.dart": None,
                        "search_products.dart": None,
                    },
                    "orders": {
                        "create_order.dart": None,
                        "get_orders.dart": None,
                    }
                }
            },
            "presentation": {
                "blocs": {
                    "auth": {
                        "auth_bloc.dart": None,
                        "auth_event.dart": None,
                        "auth_state.dart": None,
                    },
                    "product": {
                        "product_bloc.dart": None,
                        "product_event.dart": None,
                        "product_state.dart": None,
                    },
                    "order": {
                        "order_bloc.dart": None,
                        "order_event.dart": None,
                        "order_state.dart": None,
                    }
                },
                "pages": {
                    "auth": {
                        "login_page.dart": None,
                        "register_page.dart": None,
                    },
                    "home": {
                        "home_page.dart": None,
                        "widgets": {},
                    },
                    "product": {
                        "product_list_page.dart": None,
                        "product_detail_page.dart": None,
                        "widgets": {},
                    },
                    "cart_checkout": {
                        "cart_page.dart": None,
                        "checkout_page.dart": None,
                        "order_success_page.dart": None,
                    }
                },
                "widgets": {
                    "app_bar.dart": None,
                    "product_card.dart": None,
                    "loading_indicator.dart": None,
                }
            }
        }
    }
    create_folders(project_structure)
    print("Flutter project structure created successfully.")

if __name__ == "__main__":
    main()
