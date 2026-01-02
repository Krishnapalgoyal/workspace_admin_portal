module Google
  class AdminDirectoryService
    def self.users
      auth = TokenService.client

      service = Google::Apis::AdminDirectoryV1::DirectoryService.new
      service.authorization = auth

      service.list_users(customer: "my_customer").users
    end
  end
end
