package theseus.war.item
{
   import yishi.datas.templates.RoyaltyTempInfo;
   import yishi.manager.TempleteManager;
   
   public class TheseusWarEquipCellLook extends TheseusWarEquipCell
   {
      
      public function TheseusWarEquipCellLook(param1:int)
      {
         super(param1);
      }
      
      override protected function registerMediator() : void
      {
         _warBoxLock.visible = false;
      }
      
      public function setLock(param1:int) : void
      {
         var _loc2_:RoyaltyTempInfo = TempleteManager.instance.royaltyTempCate.getTempInfoByLevel(param1);
         if(_loc2_ && _loc2_.OpenWarSoul >= sonType)
         {
            isLock = false;
         }
         else
         {
            _warBoxLock.visible = true;
         }
      }
   }
}

