package christmas
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.christmas.ChristmasModel;
   import yishi.datas.templates.ChristmasActivitiesTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.ChristmasManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.NoviceBtnGlowEffect;
   
   public class ChristmasAnswerItem extends Component
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _txt:ScaleFrameImage;
      
      private var _index:int;
      
      private var _disEffect:NoviceBtnGlowEffect;
      
      private var _data:ChristmasActivitiesTempInfo;
      
      public function ChristmasAnswerItem(param1:int)
      {
         super();
         _index = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("christmasAnswerItem.bg");
         _txt = ComponentFactory.Instance.creatComponentByStylename("christmasAnswerItem.txt");
         addChild(_bg);
         addChild(_txt);
         _bg.setFrame(_index);
         _txt.setFrame(_index);
         _disEffect = new NoviceBtnGlowEffect(_bg);
         setData();
         tipStyle = "yishi.view.tips.OneLineTip";
         tipDirctions = "4,1,6,5,2,7,0,3";
         isFollowMouse = false;
      }
      
      private function setData() : void
      {
         var _loc2_:String = null;
         var _loc1_:Array = TempleteManager.instance.christmasActivitiesTempCate.getTemplatesByType(3);
         var _loc3_:ChristmasActivitiesTempInfo = _loc1_[_index - 1];
         if(_loc3_)
         {
            _data = _loc3_;
            _loc2_ = getRewardTipsStr(_loc3_);
            this.tipData = _loc2_;
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
      
      private function addEvent() : void
      {
         this.addEventListener("click",__clickHandler);
         ChristmasManager.instance.addEventListener("ANSWER_UPDATE",updateInfoHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",__clickHandler);
         ChristmasManager.instance.removeEventListener("ANSWER_UPDATE",updateInfoHandler);
      }
      
      private function updateInfoHandler(param1:NotificationEvent) : void
      {
         this.buttonMode = false;
         _disEffect.stop();
         if(_data)
         {
            if(model.rewardInfo.indexOf(_data.Id.toString()) != -1)
            {
               this.filters = [UIFilter.getGrayFilter()];
            }
            else
            {
               this.filters = [];
               if(model.answerCorrectNum >= _data.Para1)
               {
                  this.buttonMode = true;
                  _disEffect.play();
               }
            }
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
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
      
      private function get model() : ChristmasModel
      {
         return ChristmasManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_disEffect);
         _disEffect = null;
         super.dispose();
      }
   }
}

