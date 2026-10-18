package christmas
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.christmas.ChristmasModel;
   import yishi.datas.templates.ChristmasActivitiesTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ChristmasManager;
   import yishi.manager.TempleteManager;
   
   public class ChristmasAnswerPreviewItem extends Sprite implements Disposeable
   {
      
      private var _txt:ScaleFrameImage;
      
      private var _icon:ScaleFrameImage;
      
      private var _btn:IconButton;
      
      private var _bmp:Bitmap;
      
      private var _index:int;
      
      private var _data:ChristmasActivitiesTempInfo;
      
      public function ChristmasAnswerPreviewItem(param1:int)
      {
         super();
         _index = param1;
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _txt = ComponentFactory.Instance.creatComponentByStylename("christmasAnswerPreviewItem.txt");
         _icon = ComponentFactory.Instance.creatComponentByStylename("christmasAnswerPreviewItem.icon");
         _btn = ComponentFactory.Instance.creatComponentByStylename("christmasAnswerPreviewItem.btn");
         _bmp = ComponentFactory.Instance.creatBitmap("asset.ChristmasAnswerPreviewItem.bmp");
         addChild(_txt);
         addChild(_icon);
         addChild(_btn);
         addChild(_bmp);
         _txt.setFrame(_index);
         _icon.setFrame(_index);
         _icon.tipStyle = "yishi.view.tips.OneLineTip";
         _icon.tipDirctions = "4,1,6,5,2,7,0,3";
         _icon.isFollowMouse = false;
      }
      
      private function addEvent() : void
      {
         _btn.addEventListener("click",__btnClickHandler);
         ChristmasManager.instance.addEventListener("ANSWER_UPDATE",updateInfoHandler);
      }
      
      private function removeEvent() : void
      {
         _btn.removeEventListener("click",__btnClickHandler);
         ChristmasManager.instance.removeEventListener("ANSWER_UPDATE",updateInfoHandler);
      }
      
      private function updateInfoHandler(param1:NotificationEvent) : void
      {
         refreshView();
      }
      
      private function __btnClickHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         if(model.answerCorrectNum >= _data.Para1)
         {
            ChristmasManager.instance.opRequest(12,_data.Id);
         }
      }
      
      public function refreshView() : void
      {
         var _loc2_:String = null;
         var _loc1_:Array = TempleteManager.instance.christmasActivitiesTempCate.getTemplatesByType(3);
         _data = _loc1_[_index - 1];
         if(_data)
         {
            _loc2_ = getRewardTipsStr(_data);
            _icon.tipData = _loc2_;
            if(model.rewardInfo.indexOf(_data.Id.toString()) != -1)
            {
               _btn.visible = false;
               _bmp.visible = true;
            }
            else
            {
               _btn.visible = true;
               _bmp.visible = false;
               if(model.answerCorrectNum >= _data.Para1)
               {
                  _btn.enable = true;
               }
               else
               {
                  _btn.enable = false;
               }
            }
         }
      }
      
      public function getRewardTipsStr(param1:ChristmasActivitiesTempInfo) : String
      {
         var _loc3_:int = 0;
         var _loc2_:String = LanguageMgr.GetTranslation("dayguide.LimitedSellView.ActiveBoxItemTips") + "\n";
         if(param1)
         {
            _loc3_ = 1;
            while(_loc3_ <= 4)
            {
               if(param1["Reward" + _loc3_] != 0)
               {
                  _loc2_ += getGoodsName(param1["Reward" + _loc3_]) + "*" + param1["Num" + _loc3_] + "\n";
               }
               _loc3_++;
            }
         }
         return _loc2_;
      }
      
      private function getGoodsName(param1:int) : String
      {
         return TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1).TemplateName;
      }
      
      private function get model() : ChristmasModel
      {
         return ChristmasManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_bmp);
         _bmp = null;
      }
   }
}

