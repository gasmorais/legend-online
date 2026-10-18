package mailcheck
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.view.community.BaseItemView;
   
   public class MobilephoneCheckFrame extends Frame
   {
      
      private var _bg:MutipleImage;
      
      private var _btn:IconButton;
      
      private var _hbox:HBox;
      
      private var _successPrize:FilterFrameText;
      
      public function MobilephoneCheckFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc4_:BaseItemView = null;
         var _loc3_:GoodsInfo = null;
         var _loc2_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("mobilephoneCheck.bg");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("mobilephoneCheck.hbox");
         _btn = ComponentFactory.Instance.creatComponentByStylename("mobilephoneCheck.btn");
         _successPrize = ComponentFactory.Instance.creatComponentByStylename("mailcheck.successPrize");
         addToContent(_bg);
         addToContent(_btn);
         addToContent(_hbox);
         addToContent(_successPrize);
         var _loc1_:Array = ConfigInfoManager.instance.getMailCheckPrize();
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc4_ = ComponentFactory.Instance.creatCustomObject("blackjack.iconRewardView");
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = _loc1_[_loc2_].split(",")[0];
            _loc3_.count = _loc1_[_loc2_].split(",")[1];
            _loc4_.data = _loc3_;
            _hbox.addChild(_loc4_);
            _loc2_++;
         }
         _successPrize.text = LanguageMgr.GetTranslation("mailCheck.MailCheckFrame.successPrize");
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",frameResponse);
         if(_btn)
         {
            _btn.addEventListener("click",__btnHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",frameResponse);
         if(_btn)
         {
            _btn.removeEventListener("click",__btnHandler);
         }
      }
      
      private function __btnHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("mailcheck",2);
      }
      
      private function frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         ObjectUtils.disposeObject(_hbox);
         ObjectUtils.disposeObject(_bg);
         ObjectUtils.disposeObject(_btn);
      }
   }
}

