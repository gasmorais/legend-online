package consortiachess
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import consortiachess.ui.ChesspvpRdGroupUI;
   import manager.LanguageMgr;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   
   public class ChesspvpRewardFrame extends Frame
   {
      
      private var _items:Vector.<ChesspvpRdGroupUI>;
      
      private var _hbox:HBox;
      
      public function ChesspvpRewardFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:ChesspvpRdGroupUI = null;
         var _loc2_:int = 0;
         _items = new Vector.<ChesspvpRdGroupUI>();
         _hbox = new HBox();
         _hbox.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new ChesspvpRdGroupUI(_loc2_);
            _hbox.addChild(_loc1_);
            _items.push(_loc1_);
            _loc2_++;
         }
         _hbox.commitChanges();
         addToContent(_hbox);
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
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         LogicUtils.disposeDisplayCollection(_items);
         _items = null;
         super.dispose();
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("chesspvp.reward.title");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

