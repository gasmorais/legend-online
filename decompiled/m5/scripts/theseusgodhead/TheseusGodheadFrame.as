package theseusgodhead
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   
   public class TheseusGodheadFrame extends Frame
   {
      
      private var _vbox:VBox;
      
      private var _allItem:TheseusHeadInfoItem;
      
      private var _skillitem:TheseusHeadInfoItem;
      
      public function TheseusGodheadFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _vbox = ComponentFactory.Instance.creatCustomObject("theseus.TheseusYiAllFrame.vbox");
         addToContent(_vbox);
         _allItem = new TheseusHeadInfoItem(1);
         _skillitem = new TheseusHeadInfoItem(2);
         _vbox.beginChanges();
         _vbox.addChild(_allItem);
         _vbox.addChild(_skillitem);
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
         ObjectUtils.disposeObject(_allItem);
         _allItem = null;
         ObjectUtils.disposeObject(_skillitem);
         _skillitem = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         super.dispose();
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("theseus.yi.frameTitle");
         this.height = _vbox.y + _vbox.height + 100;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

