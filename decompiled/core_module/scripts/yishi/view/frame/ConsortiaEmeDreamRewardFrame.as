package yishi.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ConsortiaBossTemplateInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class ConsortiaEmeDreamRewardFrame extends Frame
   {
      
      private var outerBorder:ScaleBitmapImage;
      
      private var back:Bitmap;
      
      private var innerBorder:ScaleBitmapImage;
      
      private var winTitleText:FilterFrameText;
      
      private var lostTitleText:FilterFrameText;
      
      private var winGoodsHbox:HBox;
      
      private var lostGoodsHbox:HBox;
      
      private var sureBtn:IconButton;
      
      public function ConsortiaEmeDreamRewardFrame()
      {
         super();
         initView();
         initRewards();
         addEvent();
      }
      
      private function initView() : void
      {
         outerBorder = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossRewardFrame.outerBorder");
         back = ComponentFactory.Instance.creatBitmap("asset.ConsortiaBossRewardFrame.back");
         innerBorder = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossRewardFrame.innerBorder");
         winTitleText = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossRewardFrame.winTitleText");
         lostTitleText = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossRewardFrame.lostTitleText");
         winGoodsHbox = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossRewardFrame.winGoodsHbox");
         lostGoodsHbox = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossRewardFrame.lostGoodsHbox");
         sureBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossRewardFrame.sureBtn");
         back.x = -12;
         back.y = 9;
         winTitleText.x = 20;
         winTitleText.y = 30;
         lostTitleText.x = 20;
         lostTitleText.y = 95;
         winGoodsHbox.x = 170;
         winGoodsHbox.y = 30;
         lostGoodsHbox.x = 165;
         lostGoodsHbox.y = 95;
         addToContent(outerBorder);
         addToContent(back);
         addToContent(innerBorder);
         addToContent(winTitleText);
         addToContent(lostTitleText);
         addToContent(winGoodsHbox);
         addToContent(lostGoodsHbox);
         addToContent(sureBtn);
         winTitleText.text = LanguageMgr.GetTranslation("ConsortiaBossRewardFrame.winTitleText.text");
         lostTitleText.text = LanguageMgr.GetTranslation("ConsortiaBossRewardFrame.lostTitleText.text");
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         sureBtn.addEventListener("click",__sureClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         sureBtn.removeEventListener("click",__sureClickHandler);
      }
      
      private function initRewards() : void
      {
         var _loc9_:ConsortiaBossTemplateInfo = null;
         var _loc5_:int = 0;
         var _loc14_:Array = null;
         var _loc11_:GoodsTemplateInfo = null;
         var _loc7_:BaseItemView = null;
         var _loc13_:GoodsInfo = null;
         var _loc6_:int = 0;
         var _loc8_:Array = null;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc1_:BaseItemView = null;
         var _loc15_:GoodsInfo = null;
         winGoodsHbox.removeAllChild();
         lostGoodsHbox.removeAllChild();
         if(model.emeDreamInfo.callGrade > 0 && (model.emeDreamInfo.state == 1 || model.emeDreamInfo.state == 2))
         {
            _loc9_ = TempleteManager.instance.consortiaBossTemplateCate.getTemplateByLevel(model.emeDreamInfo.callGrade);
         }
         else
         {
            _loc9_ = TempleteManager.instance.consortiaBossTemplateCate.getTemplateByLevel(model.emeDreamInfo.grade);
         }
         if(!_loc9_)
         {
            return;
         }
         var _loc10_:Array = _loc9_.WinReward.split("|");
         var _loc4_:Array = _loc9_.LostReward.split("|");
         var _loc12_:int = int(_loc10_.length);
         var _loc2_:int = int(_loc4_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc12_)
         {
            _loc14_ = _loc10_[_loc5_].split(",");
            _loc11_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc14_[0]);
            if(_loc11_)
            {
               _loc7_ = ComponentFactory.Instance.creatCustomObject("ConsortiaBossRewardFrame.baseItem");
               _loc13_ = new GoodsInfo();
               _loc13_.templateId = _loc14_[0];
               _loc13_.count = _loc14_[1];
               _loc7_.data = _loc13_;
               winGoodsHbox.addChild(_loc7_);
            }
            _loc5_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc8_ = _loc4_[_loc6_].split(",");
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc8_[0]);
            if(_loc3_)
            {
               _loc1_ = ComponentFactory.Instance.creatCustomObject("ConsortiaBossRewardFrame.baseItem");
               _loc15_ = new GoodsInfo();
               _loc15_.templateId = _loc8_[0];
               _loc15_.count = _loc8_[1];
               _loc1_.data = _loc15_;
               lostGoodsHbox.addChild(_loc1_);
            }
            _loc6_++;
         }
      }
      
      private function __sureClickHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("consortia.view.myConsortia.activity.ConsortiaActivityListView.consortiaEmeDreamReward.title");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(outerBorder)
         {
            ObjectUtils.disposeObject(outerBorder);
         }
         outerBorder = null;
         if(back)
         {
            ObjectUtils.disposeObject(back);
         }
         back = null;
         if(innerBorder)
         {
            ObjectUtils.disposeObject(innerBorder);
         }
         innerBorder = null;
         if(winTitleText)
         {
            ObjectUtils.disposeObject(winTitleText);
         }
         winTitleText = null;
         if(lostTitleText)
         {
            ObjectUtils.disposeObject(lostTitleText);
         }
         lostTitleText = null;
         if(sureBtn)
         {
            ObjectUtils.disposeObject(sureBtn);
         }
         sureBtn = null;
         if(winGoodsHbox)
         {
            ObjectUtils.disposeAllChildren(winGoodsHbox);
            ObjectUtils.disposeObject(winGoodsHbox);
            winGoodsHbox = null;
         }
         if(lostGoodsHbox)
         {
            ObjectUtils.disposeAllChildren(lostGoodsHbox);
            ObjectUtils.disposeObject(lostGoodsHbox);
            lostGoodsHbox = null;
         }
         super.dispose();
      }
   }
}

