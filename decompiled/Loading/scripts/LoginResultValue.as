package
{
   public class LoginResultValue
   {
      
      public static const LOGIN_FAILED:String = "Login Failed";
      
      public static const USER_IS_FORBID:String = "User IS Forbid";
      
      public static const LOGIN_SUCCEED:String = "Login Succeed";
      
      public static const DATA_UPDATE_ERROR:String = "Data Update Error";
      
      public static const LOGIN_INVALIDATION:String = "Login Invalidation";
      
      public static const PARAMETER_P_DATA_ERROR:String = "Parameter P Data Error";
      
      public static const PARAMETER_SITE_DATA_ERROR:String = "Parameter Site Data Error";
      
      public static const LOGIN_SUCCEED_NO_VISUALIZE:String = "Login Succeed No Visualize";
      
      public static const LOGIN_CLOSE:String = "Login Enter Is Close";
      
      public static const LOGINWAITE_MAX:String = "Login Max";
      
      public static const CLIENT_EXCEPTION:String = "Client Exception";
      
      public static const CLIENT_EXCEPTION2:String = "Client Plug Exception";
      
      public static const P_FILTER:String = "Ip Is Forbid ";
      
      public static const CHECK_CODE_FAIL_1:String = "Check Code Failed 1";
      
      public static const CHECK_CODE_FAIL_2:String = "Check Code Failed 2";
      
      public static const CHECK_CODE_FAIL_3:String = "Check Code Failed 3";
      
      public static const CHECK_CODE_FAIL_4:String = "Check Code Failed 4";
      
      public function LoginResultValue()
      {
         super();
      }
      
      public static function getTipMessageByType(param1:String) : String
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case "Parameter P Data Error":
               _loc2_ = "Servidor está ocupado";
               break;
            case "Parameter Site Data Error":
               _loc2_ = "Erro de Parametro de Site";
               break;
            case "Login Invalidation":
               _loc2_ = "Falha do Login";
               break;
            case "Data Update Error":
               _loc2_ = "Servidor está ocupado";
               break;
            case "User IS Forbid":
               _loc2_ = "O usuário actual foi bloqueado";
               break;
            case "Login Failed":
               _loc2_ = "Servidor está ocupado";
               break;
            case "Login Succeed No Visualize":
               _loc2_ = "Servidor está ocupado";
               break;
            case "Login Max":
               _loc2_ = "Os usuários estão online já atingiu o máximo";
               break;
            case "Login Enter Is Close":
               _loc2_ = "Entrada de Log está fechada";
               break;
            case "Login Succeed":
               _loc2_ = "Login";
               break;
            case "Client Exception":
               _loc2_ = "Detectou anormalidades de Cliente, por favor login após 2 Min.";
               break;
            case "Client Plug Exception":
               _loc2_ = "A sua conta está no estado de deteção de anti-plugin, por favor, logia após 30 Min.";
               break;
            case "Ip Is Forbid ":
               _loc2_ = "O IP atual foi proibido";
               break;
            case "Check Code Failed 2":
               _loc2_ = "A sua conta está no estado de deteção de anti-plugin, por favor, logia após 5 Min. Caso falhe,começará 15 Min de deteção.";
               break;
            case "Check Code Failed 3":
               _loc2_ = "A sua conta está no estado de deteção de anti-plugin, por favor, logia após 15 Min. Caso falhe,começará 30 Min de deteção.";
               break;
            case "Check Code Failed 4":
               _loc2_ = "A sua conta está no estado de deteção de anti-plugin, por favor, logia após 30 Min. ";
               break;
            default:
               _loc2_ = param1;
         }
         return _loc2_;
      }
   }
}

