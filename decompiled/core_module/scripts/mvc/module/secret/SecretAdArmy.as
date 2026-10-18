package mvc.module.secret
{
   import mvc.module.armyII.SystemArmy;
   
   public class SecretAdArmy extends SystemArmy
   {
      
      public var viewState:int = -1;
      
      public var angle:Number = -1;
      
      public var isMoving:Boolean;
      
      public function SecretAdArmy()
      {
         super();
      }
   }
}

