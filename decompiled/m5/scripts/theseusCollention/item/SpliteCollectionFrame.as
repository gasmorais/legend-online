package theseusCollention.item
{
   import bag.view.SpliteItemFrame;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import yishi.keyboard.KeyBoardRegister;
   
   public class SpliteCollectionFrame extends SpliteItemFrame
   {
      
      public function SpliteCollectionFrame()
      {
         super();
         titleText = LanguageMgr.GetTranslation("TheseusCollenedBigItemUI.resolve");
      }
      
      override protected function __textChangHandler(param1:Event) : void
      {
         var _loc2_:int = int(_numberText.text);
         _numberText.text = Math.min(_loc2_,_goodsInfo.count).toString();
      }
      
      override protected function __confirmHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = _goodsInfo.templateId + "," + _numberText.text;
         TheseussoulManager.Instance.sendTheseusResolve(_loc2_,5);
         dispose();
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         _item = null;
         super.dispose();
      }
   }
}

