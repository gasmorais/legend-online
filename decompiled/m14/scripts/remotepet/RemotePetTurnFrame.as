package remotepet
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.RemotePetEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MagicSpringManager;
   import managers.RemotePetManager;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import mvc.module.remotepet.RemotePetModel;
   import remotepet.views.RemotePetGoodsFrame;
   import remotepet.views.RemotePetTurnDownView;
   import remotepet.views.RemotePetTurnUpView;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.view.community.MagicSpringBufferAddView;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class RemotePetTurnFrame extends Frame
   {
      
      private var _back:Scale9CornerImage;
      
      private var _titleBack:ScaleFrameImage;
      
      private var _goodsTxt:FilterFrameText;
      
      private var _orderTxt:FilterFrameText;
      
      private var _upView:RemotePetTurnUpView;
      
      private var _downView:RemotePetTurnDownView;
      
      private var _helpBtn:BaseButton;
      
      private var _sortView:RemotePetOrderFrame;
      
      private var _bufferView:MagicSpringBufferAddView;
      
      public function RemotePetTurnFrame()
      {
         super();
         initView();
         initBufferView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("remotepet.title");
         FrameControllerManager.instance.remotePetController.initTurnsData();
         _back = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetTurnFrame.bg");
         _titleBack = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetTurnFrame.titleBack");
         _goodsTxt = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetTurnFrame.goodsTxt");
         _orderTxt = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetTurnFrame.orderTxt");
         _upView = ComponentFactory.Instance.creatCustomObject("remotepet.RemotePetTurnFrame.upView");
         _downView = ComponentFactory.Instance.creatCustomObject("remotepet.RemotePetTurnFrame.downView");
         _goodsTxt.htmlText = "<a href =\'event: \'><u>" + LanguageMgr.GetTranslation("remotepet.goodsTxt") + "</u></a>";
         _orderTxt.htmlText = "<a href =\'event: \'><u>" + LanguageMgr.GetTranslation("remotepet.rankText") + "</u></a>";
         _orderTxt.mouseEnabled = true;
         _goodsTxt.mouseEnabled = true;
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetTurnFrame.HelpBtn");
         _helpBtn.tipData = LanguageMgr.GetTranslation("public.help");
         addToContent(_back);
         addToContent(_titleBack);
         addToContent(_upView);
         addToContent(_downView);
         addToContent(_helpBtn);
         addToContent(_goodsTxt);
         addToContent(_orderTxt);
         _titleBack.setFrame(1);
         __orderHandler(null);
         __updateHandler(null);
      }
      
      private function initBufferView() : void
      {
         var _loc1_:MagicSpringSlotInfo = MagicSpringManager.instance.model.checkIsExistBuffer(7);
         if(_loc1_)
         {
            _bufferView = new MagicSpringBufferAddView(_loc1_);
            _bufferView.setDescText(_loc1_.tempInfo.Desc);
            _bufferView.x = 20;
            _bufferView.y = 355;
            addToContent(_bufferView);
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _goodsTxt.addEventListener("click",__goodsHandler);
         _orderTxt.addEventListener("click",__orderHandler);
         model.addEventListener("PAGE_UPDATE",__updateHandler);
         _helpBtn.addEventListener("click",__helpHandler);
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __updateHandler(param1:RemotePetEvent) : void
      {
         _titleBack.setFrame(model.turnInfo.currPage);
      }
      
      private function __orderHandler(param1:MouseEvent) : void
      {
         if(_sortView == null)
         {
            _sortView = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetOrderFrame");
            addChild(_sortView);
         }
         else
         {
            _sortView.visible = !_sortView.visible;
            if(_sortView.visible)
            {
               FrameControllerManager.instance.remotePetController.loadRemotePetOrderData();
            }
         }
      }
      
      private function __goodsHandler(param1:MouseEvent) : void
      {
         var _loc6_:int = 0;
         var _loc7_:Array = null;
         var _loc4_:GoodsInfo = null;
         var _loc5_:Array = [];
         var _loc2_:Array = model.turnInfo.goodsList.split("|");
         _loc6_ = 0;
         while(_loc6_ < _loc2_.length)
         {
            _loc7_ = _loc2_[_loc6_].split(",");
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc7_[0];
            _loc4_.count = _loc7_[1];
            _loc5_.push(_loc4_);
            _loc6_++;
         }
         var _loc3_:RemotePetGoodsFrame = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetGoodsFrame");
         _loc3_.data = _loc5_;
         _loc3_.show(this);
         StageReferance.stage.focus = _loc3_;
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = null;
         _loc2_ = ComponentFactory.Instance.creatComponentByStylename("remotepet.helpFrame");
         _loc2_.show();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _goodsTxt.removeEventListener("click",__goodsHandler);
         _orderTxt.removeEventListener("click",__orderHandler);
         model.removeEventListener("PAGE_UPDATE",__updateHandler);
         _helpBtn.removeEventListener("click",__helpHandler);
      }
      
      private function get model() : RemotePetModel
      {
         return RemotePetManager.instance.model;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_sortView);
         _sortView = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_titleBack);
         _titleBack = null;
         ObjectUtils.disposeObject(_goodsTxt);
         _goodsTxt = null;
         ObjectUtils.disposeObject(_orderTxt);
         _orderTxt = null;
         ObjectUtils.disposeObject(_upView);
         _upView = null;
         ObjectUtils.disposeObject(_downView);
         _downView = null;
         ObjectUtils.disposeObject(_bufferView);
         _bufferView = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

