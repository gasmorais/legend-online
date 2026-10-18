package theseus
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import theseus.item.TheseusInfoItem;
   import yishi.datas.ComponentGroupType;
   
   public class TheseusSuitFrame extends Frame
   {
      
      private var _vbox:VBox;
      
      private var _weaponItem:TheseusInfoItem;
      
      private var _windItem:TheseusInfoItem;
      
      private var _otherItem:TheseusInfoItem;
      
      public function TheseusSuitFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _vbox = ComponentFactory.Instance.creatCustomObject("theseus.TheseusSuitFrame.vbox");
         addToContent(_vbox);
         _weaponItem = new TheseusInfoItem(1);
         _windItem = new TheseusInfoItem(2);
         _otherItem = new TheseusInfoItem(3);
         _vbox.beginChanges();
         _vbox.addChild(_weaponItem);
         _vbox.addChild(_windItem);
         _vbox.addChild(_otherItem);
         _vbox.commitChanges();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_weaponItem);
         _weaponItem = null;
         ObjectUtils.disposeObject(_windItem);
         _windItem = null;
         ObjectUtils.disposeObject(_otherItem);
         _otherItem = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         super.dispose();
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("theseus.equip.suitTitle");
         this.height = _vbox.y + _vbox.height + 100;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

