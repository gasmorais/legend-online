package pet.equipstore.godhead
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.resource.ResourceData;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.BuyFrameI;
   import yishi.view.tips.MessageTipManager;
   
   public class GodHeadItemView extends Component
   {
      
      private var _iconView:BaseItemView;
      
      private var _bgView:Bitmap;
      
      private var _lockView:ScaleFrameImage;
      
      private var _openBtn:BaseButton;
      
      private var _openTipTxt:FilterFrameText;
      
      private var _pos:int;
      
      private var _data:GoodsInfo;
      
      private var _state:int;
      
      private var time01:Number = 0;
      
      private var _goodsTempInfo:GoodsTemplateInfo;
      
      public function GodHeadItemView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bgView = ComponentFactory.Instance.creatCustomObject("godHeadItemView.bgView");
         _iconView = ComponentFactory.Instance.creatCustomObject("pet.GodHeadGemitem");
         _lockView = ComponentFactory.Instance.creatComponentByStylename("godHeadItemView.iconImage");
         _openBtn = ComponentFactory.Instance.creatComponentByStylename("godHeadItemView.openBtn");
         _openTipTxt = ComponentFactory.Instance.creatComponentByStylename("godHeadItemView.openTipTxt");
         _openTipTxt.text = LanguageMgr.GetTranslation("godHeadItemView.openTipTxt");
         addChild(_bgView);
         addChild(_lockView);
         addChild(_iconView);
         addChild(_openBtn);
         addChild(_openTipTxt);
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_bgView);
         _bgView = null;
         ObjectUtils.disposeObject(_iconView);
         _iconView = null;
         ObjectUtils.disposeObject(_lockView);
         _lockView = null;
         ObjectUtils.disposeObject(_openBtn);
         _openBtn = null;
         ObjectUtils.disposeObject(_openTipTxt);
         _openTipTxt = null;
      }
      
      private function initEvent() : void
      {
         _openBtn.addEventListener("click",__openHandler);
         _iconView.addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         _openBtn.removeEventListener("click",__openHandler);
         _iconView.removeEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc4_:Number = new Date().time;
         if(_loc4_ - time01 < 300)
         {
            if(_data)
            {
               SimpleAlertHelper.instance.data = [__removeJewelCallBack];
               _loc2_ = LanguageMgr.GetTranslation("public.confirm");
               _loc3_ = LanguageMgr.GetTranslation("public.cancel");
               _loc5_ = LanguageMgr.GetTranslation("public.prompt");
               _loc6_ = LanguageMgr.GetTranslation("pet.advanced.equipbag.PetBagCellDropMediator.prompt06",data.templateInfo.Property3);
               SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_);
               return;
            }
         }
         time01 = _loc4_;
      }
      
      private function __removeJewelCallBack(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:String = null;
         if(param1)
         {
            if(gold.count < _data.templateInfo.Property3)
            {
               _loc3_ = LanguageMgr.GetTranslation("pet.advanced.equipbag.PetBagCellDropMediator.goldNotEnough");
               MessageTipManager.instance().show(_loc3_);
               return;
            }
            SocketSendManager.instance.sendPunch(pos,false);
         }
      }
      
      private function get gold() : ResourceData
      {
         return ResourceManager.instance.gold;
      }
      
      private function __openHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc4_:int = int(GoodsManager.instance.getBagCountByTempId(1,3280101));
         if(_loc4_ < 1)
         {
            openBuyFrame(3280101);
            return;
         }
         if(_state == 1)
         {
            SimpleAlertHelper.instance.data = [punch,pos];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            _loc6_ = LanguageMgr.GetTranslation("pet.equipstore.godhead.GodHeadItemView.punchPrompt");
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true,false,false,2);
         }
      }
      
      private function punch(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(param1)
         {
            SocketSendManager.instance.sendPunch(param3,true);
         }
      }
      
      private function openBuyFrame(param1:int) : void
      {
         CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback,[param1]);
      }
      
      private function quickUIcallback(param1:Array) : void
      {
         var _loc3_:int = int(param1[0]);
         var _loc2_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
         var _loc4_:ShopGoodsInfo = TempleteManager.instance.getShopTempInfoByItemId(_loc3_);
         _loc2_.data(_loc4_,1);
         _loc2_.show();
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         _state = param1;
         _lockView.visible = false;
         _openBtn.visible = false;
         _openTipTxt.visible = false;
         switch(param1)
         {
            case 0:
               state0();
               break;
            case 1:
               state1();
               break;
            case 2:
               state2();
               break;
            case 3:
               state3();
               break;
            default:
               state0();
         }
      }
      
      public function set pos(param1:int) : void
      {
         _pos = param1;
      }
      
      public function get pos() : int
      {
         return _pos;
      }
      
      public function get data() : GoodsInfo
      {
         return _data;
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         _data = param1;
         _iconView.data = param1;
      }
      
      private function state0() : void
      {
         _lockView.visible = true;
         _lockView.setFrame(1);
         _openTipTxt.visible = true;
      }
      
      private function state1() : void
      {
         _lockView.visible = true;
         _lockView.setFrame(2);
         _openBtn.visible = true;
      }
      
      private function state2() : void
      {
         _lockView.visible = false;
      }
      
      private function state3() : void
      {
         _lockView.visible = true;
         _lockView.setFrame(1);
         _openTipTxt.visible = false;
      }
      
      public function get goodsTempInfo() : GoodsTemplateInfo
      {
         return _goodsTempInfo;
      }
      
      public function set goodsTempInfo(param1:GoodsTemplateInfo) : void
      {
         if(_goodsTempInfo == param1)
         {
            return;
         }
         _goodsTempInfo = param1;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
      }
   }
}

