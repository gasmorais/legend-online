package planeswar.view.eventframe
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.PlanesWarEvent;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import mvc.module.planeswar.PlanesWarModel;
   import mvc.module.planeswar.info.PlanesEventInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.PlanesEventsTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class PlanesCommonEventFrame extends PlanesEventBaseFrame
   {
      
      private var titleImage:Image;
      
      private var eventBg:ScaleBitmapImage;
      
      private var cardHbox:HBox;
      
      private var alertText:FilterFrameText;
      
      private var eventInfo:PlanesEventInfo;
      
      private var eventTempInfo:PlanesEventsTemplateInfo;
      
      private var pararms:Array;
      
      private var cardList:Array = [];
      
      private var selectIndex:int;
      
      private var _delay:uint;
      
      private var delaySelectInfo:ConfigInfosTempInfo;
      
      private var delayCount:int;
      
      private var _timer:Timer;
      
      public function PlanesCommonEventFrame()
      {
         super();
         eventInfo = model.planesWarInfo.eventInfo;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleImage = ComponentFactory.Instance.creatComponentByStylename("planesCardEventFrame.titleImage");
         eventBg = ComponentFactory.Instance.creatComponentByStylename("planesEventFrame.eventBg");
         cardHbox = ComponentFactory.Instance.creatComponentByStylename("PlanesCommonEventFrame.cardHbox");
         alertText = ComponentFactory.Instance.creatComponentByStylename("planesCardEventFrame.alertText");
         addToContent(titleImage);
         addToContent(eventBg);
         eventBg.y = 151;
         addToContent(cardHbox);
         addToContent(alertText);
         alertText.text = LanguageMgr.GetTranslation("planesCardEventFrame.alertText.text");
      }
      
      private function addEvent() : void
      {
         PlanesWarManager.instance.addEventListener("PLANES_CARDOP_BACK",__updateCardSelectHandler);
      }
      
      private function initCardView() : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         eventTempInfo = TempleteManager.instance.planesEventsTemplateCate.getTemplateByID(eventInfo.eventId);
         this.titleText = eventTempInfo.Name;
         pararms = eventInfo.params;
         var _loc1_:int = int(pararms[1]);
         if(!pararms || _loc1_ <= 0)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("planesCardEventFrame.DieLifeCardEffect0");
            cardHbox.addChild(_loc3_);
            cardList.push(_loc3_);
            if(eventInfo.respondTpye != 0)
            {
               super.closeButton.enable = true;
               _loc3_.buttonMode = false;
               _loc3_.mouseChildren = _loc3_.mouseEnabled = false;
               _loc3_.gotoAndStop(_loc3_.totalFrames - 1);
               cardHbox.spacing = (5 - _loc1_) * 5;
               cardHbox.x = 84 + (530 - cardHbox.width) / 2;
               showSelectCardView(0);
               alertText.visible = false;
               return;
            }
            _loc3_.buttonMode = true;
            _loc3_.addEventListener("click",__onCardItemClickHandler);
            super.closeButton.enable = false;
            _loc2_++;
         }
         if(eventInfo.respondTpye == 0)
         {
            _timer.addEventListener("timer",__timerHandler);
            _timer.start();
         }
         cardHbox.spacing = (5 - _loc1_) * 5;
         cardHbox.x = 84 + (530 - cardHbox.width) / 2;
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         var _loc2_:int = 0;
         delayCount = delayCount - 1;
         if(delayCount <= 0)
         {
            if(eventInfo.respondTpye == 0)
            {
               _loc2_ = Math.random() * 4;
               PlanesWarManager.instance.sendPlanesOpMsg(35,[pararms[0],_loc2_]);
            }
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
         }
      }
      
      private function __onCardItemClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         var _loc3_:int = cardList.indexOf(_loc2_);
         PlanesWarManager.instance.sendPlanesOpMsg(35,[pararms[0],_loc3_]);
      }
      
      private function __updateCardSelectHandler(param1:PlanesWarEvent) : void
      {
         var _loc3_:int = 0;
         eventInfo = model.planesWarInfo.eventInfo;
         if(eventInfo.respondTpye == 1)
         {
            if(_timer)
            {
               _timer.stop();
               _timer.removeEventListener("timer",__timerHandler);
               _timer = null;
            }
         }
         eventTempInfo = TempleteManager.instance.planesEventsTemplateCate.getTemplateByID(eventInfo.eventId);
         pararms = eventInfo.params;
         var _loc2_:int = int(pararms[0]);
         selectIndex = pararms[2];
         cardList[selectIndex].gotoAndPlay(1);
         cardList[selectIndex].addEventListener("showIcon",__refreshSelectCardView);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(cardList[_loc3_])
            {
               cardList[_loc3_].buttonMode = false;
               cardList[_loc3_].mouseChildren = cardList[_loc3_].mouseEnabled = false;
               cardList[_loc3_].removeEventListener("click",__onCardItemClickHandler);
            }
            _loc3_++;
         }
      }
      
      private function showSelectCardView(param1:int) : void
      {
         var _loc4_:MovieClip = ComponentFactory.Instance.creatCustomObject("planesCardEventFrame.DieEffect");
         var _loc2_:BaseItemView = ComponentFactory.Instance.creatCustomObject("planesEventFrame.itemView");
         var _loc5_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("planesCardEventFrame.NameTxt");
         var _loc6_:GoodsInfo = new GoodsInfo();
         _loc6_.templateId = eventInfo.params[2 * param1 + 3];
         _loc6_.count = eventInfo.params[2 * param1 + 4];
         _loc2_.data = _loc6_;
         var _loc3_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc6_.templateId);
         _loc5_.text = _loc3_.TemplateName;
         addToContentAt(_loc4_,2);
         addToContent(_loc2_);
         addToContent(_loc5_);
         _loc4_.x = cardHbox.x + cardList[param1].x - 5;
         _loc4_.y = cardHbox.y + cardList[param1].y - 5;
         _loc2_.x = cardHbox.x + cardList[param1].x - 35;
         _loc2_.y = cardHbox.y + cardList[param1].y - 50;
         _loc5_.x = _loc2_.x - 10;
         _loc5_.y = _loc2_.y + 75;
      }
      
      private function __refreshSelectCardView(param1:Event) : void
      {
         showSelectCardView(selectIndex);
         cardList[selectIndex].removeEventListener("showIcon",__refreshSelectCardView);
         if(_delay == 0)
         {
            _delay = setTimeout(showOtherCardsState,1000);
         }
      }
      
      private function showOtherCardsState() : void
      {
         var _loc1_:int = 0;
         _delay = 0;
         _loc1_ = 0;
         while(_loc1_ < cardList.length)
         {
            if(_loc1_ != selectIndex)
            {
               cardList[_loc1_].gotoAndPlay(1);
               cardList[_loc1_].addEventListener("showIcon",__refreshOtherCardView);
            }
            _loc1_++;
         }
      }
      
      private function __refreshOtherCardView(param1:Event) : void
      {
         var _loc3_:int = cardList.indexOf(param1.currentTarget);
         if(_loc3_ == -1)
         {
            return;
         }
         var _loc4_:BaseItemView = ComponentFactory.Instance.creatCustomObject("planesEventFrame.itemView");
         var _loc5_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("planesCardEventFrame.NameTxt");
         var _loc6_:GoodsInfo = new GoodsInfo();
         _loc6_.templateId = eventInfo.params[2 * _loc3_ + 3];
         _loc6_.count = eventInfo.params[2 * _loc3_ + 4];
         _loc4_.data = _loc6_;
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc6_.templateId);
         _loc5_.text = _loc2_.TemplateName;
         addToContent(_loc4_);
         addToContent(_loc5_);
         _loc4_.x = cardHbox.x + cardList[_loc3_].x - 35;
         _loc4_.y = cardHbox.y + cardList[_loc3_].y - 50;
         _loc5_.x = _loc4_.x - 10;
         _loc5_.y = _loc4_.y + 75;
         cardList[_loc3_].removeEventListener("showIcon",__refreshOtherCardView);
         if(eventInfo.respondTpye == 1)
         {
            this.closeButton.enable = true;
         }
      }
      
      private function get model() : PlanesWarModel
      {
         return PlanesWarManager.instance.model;
      }
      
      private function removeEvent() : void
      {
         PlanesWarManager.instance.removeEventListener("PLANES_CARDOP_BACK",__updateCardSelectHandler);
      }
      
      override public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
         delaySelectInfo = TempleteManager.instance.getConfigInfoByConfigName("planes_max_pick_card_time");
         if(delaySelectInfo)
         {
            delayCount = int(delaySelectInfo.ConfigValue) / 1000;
         }
         _timer = new Timer(1000);
         initCardView();
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         if(_delay > 0)
         {
            clearTimeout(_delay);
         }
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
            _timer = null;
         }
         KeyBoardRegister.instance.keyEnable = true;
         if(titleImage)
         {
            ObjectUtils.disposeObject(titleImage);
         }
         titleImage = null;
         if(eventBg)
         {
            ObjectUtils.disposeObject(eventBg);
         }
         eventBg = null;
         if(cardList)
         {
            _loc1_ = 0;
            while(_loc1_ < cardList.length)
            {
               (cardList[_loc1_] as MovieClip).stop();
               ObjectUtils.disposeObject(cardList[_loc1_]);
               cardList[_loc1_] = null;
               _loc1_++;
            }
            cardList = null;
         }
         if(cardHbox)
         {
            cardHbox.removeAllChild();
            ObjectUtils.disposeObject(cardHbox);
            titleImage = null;
         }
         if(alertText)
         {
            ObjectUtils.disposeObject(alertText);
         }
         alertText = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

