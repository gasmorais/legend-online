package yishi.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildSender;
   import yishi.datas.ComponentGroupType;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildSexFrame extends Frame
   {
      
      private var _describeTxt:FilterFrameText;
      
      private var _confirmBtn:IconButton;
      
      private var _group:SelectedButtonGroup;
      
      private var _hBox:HBox;
      
      private var _pos:int;
      
      public function ChildSexFrame()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("public.prompt1");
         _describeTxt = ComponentFactory.Instance.creatComponentByStylename("ChildSexFrame.describeTxt");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("ChildSexFrame.confirmBtn");
         _hBox = new HBox();
         _group = new SelectedButtonGroup();
         addToContent(_describeTxt);
         addToContent(_hBox);
         addToContent(_confirmBtn);
         _describeTxt.text = LanguageMgr.GetTranslation("yishi.view.frame.ChildSexFrame.describeTxt");
         _hBox.spacing = 5;
         _hBox.x = 55;
         _hBox.y = 40;
      }
      
      private function unitView() : void
      {
         if(_describeTxt)
         {
            _describeTxt.dispose();
         }
         _describeTxt = null;
         if(_confirmBtn)
         {
            _confirmBtn.dispose();
         }
         _confirmBtn = null;
         if(_group)
         {
            _group.dispose();
         }
         _group = null;
         if(_hBox)
         {
            _hBox.dispose();
         }
         _hBox = null;
      }
      
      private function refreshView() : void
      {
         var _loc3_:SelectedTextButton = null;
         var _loc2_:int = 0;
         _group.removeAllItem();
         _hBox.disposeAllChildren();
         var _loc1_:Array = LanguageMgr.GetTranslation("yishi.view.frame.ChildSexFrame.selectTxt").split(",");
         var _loc4_:int = 3;
         _hBox.x = 55;
         if(ChildManager.instance.model.applyInfo.state == 0 && !ChildManager.instance.model.applyInfo.isApply)
         {
            _loc4_ = 2;
            _hBox.x = 104;
         }
         else if(ChildManager.instance.model.childList.length >= 3)
         {
            _loc4_ = 2;
            _hBox.x = 104;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("ChildSexFrame.selectedBtn");
            _loc3_.text = _loc1_[_loc2_];
            _hBox.addChild(_loc3_);
            _group.addSelectItem(_loc3_);
            _loc2_++;
         }
         _group.selectIndex = 0;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _confirmBtn.addEventListener("click",__confirmHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _confirmBtn.removeEventListener("click",__confirmHandler);
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __confirmHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(_group)
         {
            if(ChildManager.instance.model.applyInfo.state == 0)
            {
               ChildSender.choiceSex(_group.selectIndex,_pos);
            }
            else
            {
               _loc2_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command10");
               MessageTipManager.instance().show(_loc2_);
            }
            dispose();
         }
      }
      
      public function show(param1:int) : void
      {
         _pos = param1;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unitView();
         super.dispose();
      }
   }
}

