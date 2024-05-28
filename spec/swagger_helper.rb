# frozen_string_literal: true

require "rails_helper"

shared_components = {
  securitySchemes: {
    basic_auth: {
      type: :http,
      scheme: :basic
    },
    bearer_auth: {
      type: :http,
      scheme: :bearer,
      bearerFormat: :JWT
    }
  },
  schemas: {
    detail_example: {
      type: :object,
      properties: {
        id: {type: :integer, example: 1, description: "Custom data's ID"},
        name: {type: :string, example: "新井 遼", description: "Name of Custom data"},
        category: {type: :string, example: "観光スポット", description: "Category of the Custom data"},
        description: {type: :string, example: "「雪まつり」の会場としても全国に知られる有名スポット",
                      description: "Description of the Custom data"},
        url: {type: :string, example: "https://odori-park.jp/", description: "URL of the Custom data's website"}
      }
    },
    server_error: {
      type: :object,
      properties: {
        errors: {
          type: :array,
          items: {
            type: :object,
            properties: {
              code: {type: :string, example: "B-00001", description: "Type of error"},
              message: {type: :string, example: "CDCなど外部サービスからHttpレスポンス500場合", description: "Error message"}
            }
          }
        }
      }
    },
    unauthorized: {
      type: :object,
      properties: {
        errors: {
          type: :array,
          items: {
            type: :object,
            properties: {
              code: {type: :string, example: "S-00001", description: "Type of error"},
              message: {type: :string, example: "トークン期限切れなどの場合", description: "Error message"}
            }
          }
        }
      }
    },
    bad_request: {
      type: :object,
      properties: {
        errors: {
          type: :array,
          items: {
            type: :object,
            properties: {
              code: {type: :string, example: "C-00001", description: "Type of error"},
              message: {type: :string, example: "リクエスト異常もしくは実行失敗。詳細理由はBodyのエラーコードを確認して下さい。",
                        description: "Error message"}
            }
          }
        }
      }
    },
    unprocessable_entity: {
      type: :object,
      properties: {
        errors: {
          type: :array,
          items: {
            type: :object,
            properties: {
              resource: {type: :string, example: "admin", description: "Resource has error"},
              field: {type: :string, example: "email", description: "Field has error"},
              code: {type: :string, example: "M-00001", description: "Type of invalid (error or confirm)"},
              message: {type: :string, example: "メールアドレスもしくはパスワードが正しくありません", description: "Message has error"}
            }
          }
        }
      }
    },
    not_found: {
      type: :object,
      properties: {
        errors: {
          type: :array,
          items: {
            type: :object,
            properties: {
              resource: {type: :string, example: "custom_data", description: "Resource has error"},
              code: {type: :string, example: "B-00003",
                     description: "Type of invalid (error or confirm)"},
              message: {type: :string, example: "該当する情報は見つかりませんでした。", description: "Error message"}
            }
          }
        }
      }
    },
    pagy_info: {
      type: :object,
      properties: {
        count: {type: :integer, example: 1, description: "Total record"},
        page: {type: :integer, example: 1, description: "Current page"},
        outset: {type: :integer, example: 1, description: "Initial offset"},
        items: {type: :integer, example: 1, description: "Total record per page"},
        last: {type: :integer, example: 1, description: "Last page"},
        pages: {type: :integer, example: 1, description: "Total page"},
        offset: {type: :integer, example: 1, description: "Total items skip"},
        from: {type: :integer, example: 1, description: "Index of first record in page"},
        to: {type: :integer, example: 1, description: "Index of last record in page"},
        in: {type: :integer, example: 1, description: "Total record in page"},
        prev: {type: :integer, example: 1, description: "Before page"},
        next: {type: :integer, example: 1, description: "After page"},
        limit: {type: :integer, example: 1, description: "Limit record per page"}
      }
    }
  }
}

RSpec.configure do |config|
  config.openapi_root = Rails.root.join("swagger").to_s

  config.openapi_specs = {
    "v1/swagger.yaml" => {
      openapi: "3.0.1",
      info: {
        title: "API V1",
        version: "v1"
      },
      paths: {},
      components: shared_components,
      servers: [
        {
          url: "{defaultHost}",
          variables: {
            defaultHost: {
              default: ENV.fetch("SWAGGER_DEFAULT_HOST", nil)
            }
          }
        }
      ]
    }
  }

  config.openapi_format = :yaml
end
