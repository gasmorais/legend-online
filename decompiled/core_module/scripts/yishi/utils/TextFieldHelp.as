package yishi.utils
{
   import flash.text.TextField;
   
   public class TextFieldHelp
   {
      
      public function TextFieldHelp()
      {
         super();
      }
      
      public static function limitLines(param1:TextField, param2:int) : void
      {
         if(param1.numLines > param2)
         {
            param1.replaceText(param1.getLineOffset(param2),param1.length,"");
         }
      }
   }
}

