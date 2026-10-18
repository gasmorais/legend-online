package demonland
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.demonland.DemonLandModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.DemonLandDropTemplate;
   import yishi.datas.templates.DemonLandTemplate;
   import yishi.events.NotificationEvent;
   import yishi.manager.DemonLandManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.OldPlayerReturnManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   
   public class AwardView extends Frame
   {
      
      private var _str3:Image;
      
      private var _str2:Image;
      
      private var _str1:Image;
      
      private var _bg4:Image;
      
      private var _bg3:Image;
      
      private var _bg2:Image;
      
      private var _btnAttack:IconButton;
      
      private var _btnSwap:IconButton;
      
      private var _imgAttBg:Image;
      
      private var _imgTear:Image;
      
      private var _txtCost:FilterFrameText;
      
      private var _txtAttCount:FilterFrameText;
      
      private var template:DemonLandTemplate;
      
      private var arrAtt:Array;
      
      private var arrFirst:Array;
      
      private var spAtt:Sprite;
      
      private var spFirst:Sprite;
      
      private var _btnBuyCount:BaseButton;
      
      public function AwardView()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         var _loc2_:BaseItemView = null;
         var _loc1_:GoodsInfo = null;
         var _loc3_:DemonLandDropTemplate = null;
         var _loc5_:int = 0;
         var _loc6_:Image = null;
         titleText = DemonLandManager.instance.model.selectedChapter + "-" + DemonLandManager.instance.model.selectedNode;
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("DemonLand.AwardView.bg2");
         addToContent(_bg2);
         _bg3 = ComponentFactory.Instance.creatComponentByStylename("DemonLand.AwardView.bg3");
         addToContent(_bg3);
         _bg4 = ComponentFactory.Instance.creatComponentByStylename("DemonLand.AwardView.bg4");
         addToContent(_bg4);
         _str3 = ComponentFactory.Instance.creatComponentByStylename("DemonLand.AwardView.str3");
         addToContent(_str3);
         _str2 = ComponentFactory.Instance.creatComponentByStylename("DemonLand.AwardView.str2");
         addToContent(_str2);
         _str1 = ComponentFactory.Instance.creatComponentByStylename("DemonLand.AwardView.str1");
         addToContent(_str1);
         _btnAttack = ComponentFactory.Instance.creatComponentByStylename("DemonLand.AwardView.btnAttack");
         addToContent(_btnAttack);
         _btnSwap = ComponentFactory.Instance.creatComponentByStylename("DemonLand.AwardView.btnSwap");
         addToContent(_btnSwap);
         _imgAttBg = ComponentFactory.Instance.creatComponentByStylename("DemonLand.AwardView.attbg");
         _btnAttack.addChild(_imgAttBg);
         _imgTear = ComponentFactory.Instance.creatComponentByStylename("DemonLand.AwardView.imgTear");
         _btnAttack.addChild(_imgTear);
         _txtCost = ComponentFactory.Instance.creatComponentByStylename("DemonLand.AwardView.txtCost");
         _btnAttack.addChild(_txtCost);
         _txtAttCount = ComponentFactory.Instance.creatComponentByStylename("DemonLand.AwardView.txtAttCount");
         addToContent(_txtAttCount);
         _btnBuyCount = ComponentFactory.Instance.creatComponentByStylename("DemonLand.AwardView.btnAddCount");
         addToContent(_btnBuyCount);
         template = TempleteManager.instance.demonLandTemplateCate.getTemplateByChapterAndNodeId(DemonLandManager.instance.model.selectedChapter,DemonLandManager.instance.model.selectedNode);
         _txtCost.text = "-" + template.Cost;
         arrFirst = TempleteManager.instance.demonLandDropTemplateCate.getTemplatesByDropId(template.FirstDropId);
         arrAtt = TempleteManager.instance.demonLandDropTemplateCate.getTemplatesByDropId(template.AttackDropId);
         spFirst = new Sprite();
         spAtt = new Sprite();
         addToContent(spFirst);
         addToContent(spAtt);
         spFirst.x = 70;
         spFirst.y = 100;
         spAtt.x = 70;
         spAtt.y = 215;
         var _loc4_:int = 75;
         _loc5_ = 0;
         while(_loc5_ < arrFirst.length)
         {
            _loc3_ = arrFirst[_loc5_];
            _loc2_ = ComponentFactory.Instance.creatCustomObject("demonland.goodsItem3");
            _loc1_ = new GoodsInfo();
            _loc1_.templateId = _loc3_.ItemId;
            _loc1_.count = _loc3_.Count;
            _loc2_.data = _loc1_;
            spFirst.addChild(_loc2_);
            _loc2_.x = _loc5_ * _loc4_;
            if(DemonLandManager.instance.model.isPassed)
            {
               _loc6_ = ComponentFactory.Instance.creatComponentByStylename("DemonLand.DemonLandFrame.awardGet");
               _loc2_.addChild(_loc6_);
               _loc6_.x = 10;
               _loc6_.y = 20;
               _loc6_.mouseEnabled = _loc6_.mouseChildren = false;
            }
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < arrAtt.length)
         {
            _loc3_ = arrAtt[_loc5_];
            _loc2_ = ComponentFactory.Instance.creatCustomObject("demonland.goodsItem3");
            _loc1_ = new GoodsInfo();
            _loc1_.templateId = _loc3_.ItemId;
            _loc1_.count = _loc3_.Count;
            _loc2_.data = _loc1_;
            spAtt.addChild(_loc2_);
            _loc2_.x = _loc5_ * _loc4_;
            _loc5_++;
         }
         if(DemonLandManager.instance.getLandTemplate().AttackCount == 0)
         {
            _txtAttCount.visible = false;
            _str3.visible = false;
            _btnBuyCount.visible = false;
         }
         updateCountShow();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _btnSwap.addEventListener("click",_btnSwapClickHandler);
         _btnAttack.addEventListener("click",_btnAttackClickHandler);
         _btnBuyCount.addEventListener("click",onClickBuyCount);
         NotificationManager.instance.addEventListener("DEMON_LAND_DATA",updateData);
      }
      
      private function _btnSwapClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("mopup",13);
      }
      
      private function _btnAttackClickHandler(param1:MouseEvent) : void
      {
         var _loc4_:String = null;
         var _loc6_:int = 0;
         var _loc5_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc7_:String = null;
         if(model.checkIsNeedBuyAlert())
         {
            _loc4_ = TempleteManager.instance.getConfigInfoByConfigName("evilland_goddess_tear_config").ConfigValue;
            _loc6_ = int(OldPlayerReturnManager.instance.model.demonLandCount);
            _loc5_ = LanguageMgr.GetTranslation("demonland.main.text5",int(_loc4_.split(",")[3]),int(_loc4_.split(",")[2]) + _loc6_ - DemonLandManager.instance.model.tearBuyCount);
            SimpleAlertHelper.instance.data = [buyTearConfirm];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc7_ = LanguageMgr.GetTranslation("public.prompt");
            SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc5_,_loc2_,_loc3_,true,true);
            return;
         }
         model.isChapterEndBoss = false;
         if(model.maxChapterId == model.selectedChapter && model.selectedNode == 10)
         {
            model.isChapterEndBoss = true;
         }
         model.preMaxChapterId = model.maxChapterId;
         DemonLandManager.instance.sendEnterDemonLandNode(model.selectedChapter,model.selectedNode);
      }
      
      private function buyTearConfirm(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            DemonLandManager.instance.sendBuyTear();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_btnSwap)
         {
            _btnSwap.removeEventListener("click",_btnSwapClickHandler);
         }
         if(_btnAttack)
         {
            _btnAttack.removeEventListener("click",_btnAttackClickHandler);
         }
         _btnBuyCount.removeEventListener("click",onClickBuyCount);
         NotificationManager.instance.removeEventListener("DEMON_LAND_DATA",updateData);
      }
      
      private function updateData(param1:NotificationEvent) : void
      {
         updateCountShow();
      }
      
      private function updateCountShow() : void
      {
         var _loc3_:int = int(DemonLandManager.instance.getLandTemplate().AttackCount);
         var _loc1_:int = int(DemonLandManager.instance.getNodeMsg().attackCount);
         var _loc2_:int = int(DemonLandManager.instance.getNodeMsg().buyCount);
         var _loc4_:int = _loc3_ - _loc1_ + _loc2_;
         _txtAttCount.text = _loc4_ + "/" + _loc3_;
         if(_loc4_ > 0 || _loc3_ == 0)
         {
            _btnAttack.enable = _btnSwap.enable = true;
         }
         else
         {
            _btnAttack.enable = _btnSwap.enable = false;
         }
         if(_loc4_ == _loc3_)
         {
            _btnBuyCount.enable = false;
         }
         else
         {
            _btnBuyCount.enable = true;
         }
         if(_btnSwap.enable)
         {
            _btnSwap.enable = DemonLandManager.instance.model.isPassed;
         }
      }
      
      private function onClickBuyCount(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("demonland.main.text4",int(TempleteManager.instance.getConfigInfoByConfigName("evilland_buy_count_cost").ConfigValue),DemonLandManager.instance.getLandTemplate().AttackCount - DemonLandManager.instance.getNodeMsg().buyCount);
         SimpleAlertHelper.instance.data = [realBuy];
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc2_,_loc3_,_loc4_,true,true);
      }
      
      private function realBuy(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            DemonLandManager.instance.sendBuyAttackCount(DemonLandManager.instance.model.selectedChapter,DemonLandManager.instance.model.selectedNode);
         }
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get model() : DemonLandModel
      {
         return DemonLandManager.instance.model;
      }
      
      override public function dispose() : void
      {
         NotificationManager.instance.dispatchEvent(new NotificationEvent("DEMON_LAND_CLOSE_AWARD_VIEW"));
         removeEvent();
         ObjectUtils.disposeObject(_str3);
         _str3 = null;
         ObjectUtils.disposeObject(_str2);
         _str2 = null;
         ObjectUtils.disposeObject(_str1);
         _str1 = null;
         ObjectUtils.disposeObject(_bg4);
         _bg4 = null;
         ObjectUtils.disposeObject(_bg3);
         _bg3 = null;
         ObjectUtils.disposeObject(_bg2);
         _bg2 = null;
         ObjectUtils.disposeObject(_btnAttack);
         _btnAttack = null;
         ObjectUtils.disposeObject(_btnSwap);
         _btnSwap = null;
         ObjectUtils.disposeObject(_imgAttBg);
         _imgAttBg = null;
         ObjectUtils.disposeObject(_imgTear);
         _imgTear = null;
         ObjectUtils.disposeObject(_txtCost);
         _txtCost = null;
         ObjectUtils.disposeObject(_txtAttCount);
         _txtAttCount = null;
         ObjectUtils.disposeObject(_btnBuyCount);
         _btnBuyCount = null;
         ObjectUtils.disposeObject(spFirst);
         spFirst = null;
         ObjectUtils.disposeObject(spAtt);
         spAtt = null;
         template = null;
         arrAtt = null;
         arrFirst = null;
         super.dispose();
      }
   }
}

