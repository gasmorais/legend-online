package mvc.module.secretary.acts
{
   import mvc.module.secretary.SecretaryItemData;
   
   public class LittleActionFactory
   {
      
      public function LittleActionFactory()
      {
         super();
      }
      
      public static function creatAction(param1:SecretaryItemData) : ILitteAction
      {
         var _loc2_:ILitteAction = null;
         switch(param1.type - 1)
         {
            case 0:
               _loc2_ = new OfferAction(param1.type,param1.moneyState);
               break;
            case 1:
               _loc2_ = new DixAction(param1);
               break;
            case 2:
               _loc2_ = new SyAction(param1);
               break;
            case 3:
               _loc2_ = new LyAction(param1);
               break;
            case 4:
               _loc2_ = new GemAction();
               break;
            case 5:
               _loc2_ = new LevyAction();
               break;
            case 6:
               _loc2_ = new LabAction();
               break;
            case 7:
               _loc2_ = new FarmAction();
               break;
            case 8:
               _loc2_ = new AltarAction();
         }
         return _loc2_;
      }
   }
}

