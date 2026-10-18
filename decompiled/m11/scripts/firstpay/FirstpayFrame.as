package firstpay
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.FirstChargeTemplate;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class FirstpayFrame extends Frame
   {
      
      private var _bg:MutipleImage;
      
      private var _itemContan:HBox;
      
      private var _payBtn:BaseButton;
      
      private var _weapon:MovieClip;
      
      private var _itemEffect:MovieImage;
      
      private var list:Array;
      
      public function FirstpayFrame()
      {
         super();
         initView();
         refreshGoods();
         initEvent();
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("firstpay.FirstPayFrameBack");
         _itemContan = ComponentFactory.Instance.creatComponentByStylename("firstpay.ItemBox");
         titleText = LanguageMgr.GetTranslation("firstpay.FirstpayFrame.titleTxt");
         _payBtn = ComponentFactory.Instance.creatComponentByStylename("firstpay.PayBtn");
         list = [];
         _itemEffect = ComponentFactory.Instance.creatComponentByStylename("firstpay.itemEffect");
         _itemEffect.mouseChildren = _itemEffect.mouseEnabled = false;
      }
      
      private function refreshGoods() : void
      {
         var _loc3_:int = 0;
         var _loc5_:GoodsInfo = null;
         var _loc2_:BaseItemView = null;
         var _loc4_:int = int(ArmyManager.instance.thane.job);
         var _loc1_:Array = TempleteManager.instance.firstPayDropTempalteCate.getTemplatesListByJob(_loc4_);
         _loc1_.sort(sortMasterType);
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = (_loc1_[_loc3_] as FirstChargeTemplate).ItemId;
            _loc5_.count = (_loc1_[_loc3_] as FirstChargeTemplate).Count;
            _loc2_ = ComponentFactory.Instance.creatCustomObject("firstpay.Item");
            _loc2_.data = _loc5_;
            if(_loc5_.templateInfo.Profile == 4)
            {
               setEffect(_loc3_);
            }
            _itemContan.addChild(_loc2_);
            _loc3_++;
         }
      }
      
      private function setEffect(param1:int) : void
      {
         var _loc2_:MovieImage = ComponentFactory.Instance.creatComponentByStylename("firstpay.itemEffect02");
         _loc2_.x = param1 * 67 + 60;
         _loc2_.mouseChildren = _loc2_.mouseEnabled = false;
         list.push(_loc2_);
      }
      
      private function sortMasterType(param1:Object, param2:Object) : int
      {
         var _loc3_:int = 0;
         var _loc5_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.ItemId);
         var _loc4_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param2.ItemId);
         if(_loc5_.Profile > _loc4_.Profile)
         {
            _loc3_ = -1;
         }
         else if(_loc5_.Profile < _loc4_.Profile)
         {
            _loc3_ = 1;
         }
         else if(_loc5_.MasterType > _loc4_.MasterType)
         {
            _loc3_ = 1;
         }
         else if(_loc5_.MasterType < _loc4_.MasterType)
         {
            _loc3_ = -1;
         }
         else if(_loc5_.TemplateId > _loc4_.TemplateId)
         {
            _loc3_ = -1;
         }
         else if(_loc5_.TemplateId < _loc4_.TemplateId)
         {
            _loc3_ = 1;
         }
         else
         {
            _loc3_ = 0;
         }
         _loc5_ = null;
         _loc4_ = null;
         return _loc3_;
      }
      
      override protected function addChildren() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.addChildren();
         if(_closeButton)
         {
            addToContent(_closeButton);
         }
         if(_bg)
         {
            addToContent(_bg);
         }
         if(_payBtn)
         {
            addToContent(_payBtn);
         }
         if(_itemContan)
         {
            addToContent(_itemContan);
         }
         if(_itemEffect)
         {
            addToContent(_itemEffect);
         }
         if(list)
         {
            _loc1_ = int(list.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               addToContent(list[_loc2_]);
               _loc2_++;
            }
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__response);
         _payBtn.addEventListener("click",__payHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__response);
         _payBtn.removeEventListener("click",__payHandler);
      }
      
      private function __payHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         RechargeAlertMannager.navigateToRechargePage();
         dispose();
      }
      
      private function __response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 1 || param1.responseCode == 0)
         {
            dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
         initWeapon();
      }
      
      private function initWeapon() : void
      {
         var _loc2_:int = int(ArmyManager.instance.thane.job);
         if(_loc2_ > 3)
         {
            _loc2_ -= 3;
         }
         var _loc1_:String = ComponentSetting.getUISourcePath("weapon" + _loc2_);
         LoaderManagerII.instance.load(_loc1_,3,5,__loadCompleteHandler);
      }
      
      private function __loadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(isDie)
         {
            return;
         }
         var _loc6_:int;
         switch((_loc6_ = int(ArmyManager.instance.thane.job)) - 1)
         {
            case 0:
            case 3:
               _loc3_ = 519;
               _loc4_ = 101;
               break;
            case 1:
            case 4:
               _loc3_ = 501;
               _loc4_ = 120;
               break;
            case 2:
            case 5:
               _loc3_ = 501;
               _loc4_ = 120;
         }
         if(!ModuleLoader.hasDefinition("asset.firstpay.weapon"))
         {
            return;
         }
         var _loc5_:Class = ModuleLoader.getDefinition("asset.firstpay.weapon");
         _weapon = new _loc5_() as MovieClip;
         addToContent(_weapon);
         _weapon.x = _loc3_;
         _weapon.y = _loc4_;
         _weapon.mouseChildren = _weapon.mouseEnabled = false;
      }
      
      private function uinit() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = int(list.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            ObjectUtils.disposeObject(list[_loc2_]);
            _loc2_++;
         }
         list = null;
      }
      
      override public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__loadCompleteHandler);
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_itemContan);
         _itemContan = null;
         ObjectUtils.disposeObject(_payBtn);
         _payBtn = null;
         ObjectUtils.disposeObject(_itemEffect);
         _itemEffect = null;
         if(_weapon)
         {
            ObjectUtils.disposeObject(_weapon);
         }
         _weapon = null;
         uinit();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

