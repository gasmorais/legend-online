package sandbox.daylight
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.controler.DayLightController;
   import sandbox.daylight.event.DayLightEvent;
   import yishi.datas.templates.CampaignBufferTemp;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   
   public class DayLightRightView extends Sprite implements Disposeable
   {
      
      private var _bg:Image;
      
      private var _titleImg:Image;
      
      private var _rankListTxt:FilterFrameText;
      
      private var _bufferItem1:DayLightBufferItemView;
      
      private var _bufferItem2:DayLightBufferItemView;
      
      private var _bufferItem3:DayLightBufferItemView;
      
      private var _bufferItem4:DayLightBufferItemView;
      
      private var _bufferItem5:DayLightBufferItemView;
      
      private var _infoTeamTxt:FilterFrameText;
      
      private var _infoTeamImg:ScaleFrameImage;
      
      private var _infoStateTxt:FilterFrameText;
      
      private var _infoStateValueTxt:FilterFrameText;
      
      private var _infoKillTxt:FilterFrameText;
      
      private var _infoKillValueBg:Image;
      
      private var _infoKillValueTxt:FilterFrameText;
      
      private var _infoExchangeTxt:FilterFrameText;
      
      private var _infoExchangeValueBg:Image;
      
      private var _infoExchangeValueTxt:FilterFrameText;
      
      private var _infoScoreTxt:FilterFrameText;
      
      private var _infoScoreValueBg:Image;
      
      private var _infoScoreValueTxt:FilterFrameText;
      
      private var _bufferItemDic:Dictionary = new Dictionary();
      
      private var _controller:DayLightController = FrameControllerManager.instance.dayLightControler;
      
      private var _model:DayLightModel = _controller.model;
      
      public function DayLightRightView()
      {
         super();
         initView();
         addEvent();
         initBufferList();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightRightView.Bg");
         _titleImg = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightRightView.titleImg");
         _rankListTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightRightView.rankListTxt");
         _bufferItem1 = ComponentFactory.Instance.creatCustomObject("daylight.DayLightRightView.bufferItem1");
         _bufferItem2 = ComponentFactory.Instance.creatCustomObject("daylight.DayLightRightView.bufferItem2");
         _bufferItem3 = ComponentFactory.Instance.creatCustomObject("daylight.DayLightRightView.bufferItem3");
         _bufferItem4 = ComponentFactory.Instance.creatCustomObject("daylight.DayLightRightView.bufferItem4");
         _bufferItem5 = ComponentFactory.Instance.creatCustomObject("daylight.DayLightRightView.bufferItem5");
         _infoTeamTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightRightView.infoTeamTxt");
         _infoTeamImg = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightRightView.infoTeamImg");
         _infoStateTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightRightView.infoStateTxt");
         _infoStateValueTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightRightView.infoStateValueTxt");
         _infoKillTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightRightView.infoKillTxt");
         _infoKillValueBg = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightRightView.infoKillValueBg");
         _infoKillValueTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightRightView.infoKillValueTxt");
         _infoExchangeTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightRightView.infoExchangeTxt");
         _infoExchangeValueBg = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightRightView.infoExchangeValueBg");
         _infoExchangeValueTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightRightView.infoExchangeValueTxt");
         _infoScoreTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightRightView.infoScoreTxt");
         _infoScoreValueBg = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightRightView.infoScoreValueBg");
         _infoScoreValueTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightRightView.infoScoreValueTxt");
         _rankListTxt.htmlText = LanguageMgr.GetTranslation("sandbox.daylight.DayLightRightView.tipsTxt01");
         _infoTeamTxt.text = LanguageMgr.GetTranslation("sandbox.daylight.DayLightRightView.tipsTxt02");
         _infoStateTxt.text = LanguageMgr.GetTranslation("sandbox.daylight.DayLightRightView.tipsTxt03");
         _infoKillTxt.text = LanguageMgr.GetTranslation("sandbox.daylight.DayLightRightView.tipsTxt04");
         _infoExchangeTxt.text = LanguageMgr.GetTranslation("sandbox.daylight.DayLightRightView.tipsTxt05");
         _infoScoreTxt.text = LanguageMgr.GetTranslation("sandbox.daylight.DayLightRightView.tipsTxt06");
         _rankListTxt.mouseEnabled = true;
         _infoTeamImg.setFrame(1);
         _infoStateValueTxt.text = LanguageMgr.GetTranslation("sandbox.daylight.DayLightRightView.stateTxt01");
         _infoKillValueTxt.text = "0";
         _infoExchangeValueTxt.text = "0";
         _infoScoreValueTxt.text = "0";
         addChild(_bg);
         addChild(_titleImg);
         addChild(_rankListTxt);
         addChild(_bufferItem1);
         addChild(_bufferItem2);
         addChild(_bufferItem3);
         addChild(_bufferItem4);
         addChild(_bufferItem5);
         addChild(_infoTeamTxt);
         addChild(_infoTeamImg);
         addChild(_infoStateTxt);
         addChild(_infoStateValueTxt);
         addChild(_infoKillTxt);
         addChild(_infoKillValueBg);
         addChild(_infoKillValueTxt);
         addChild(_infoExchangeTxt);
         addChild(_infoExchangeValueBg);
         addChild(_infoExchangeValueTxt);
         addChild(_infoScoreTxt);
         addChild(_infoScoreValueBg);
         addChild(_infoScoreValueTxt);
      }
      
      private function initBufferList() : void
      {
         var _loc1_:CampaignBufferTemp = null;
         var _loc2_:Array = TempleteManager.instance.campaignBufferTemplate.getTemplateByType(40);
         if(_loc2_.length >= 5)
         {
            _loc1_ = _loc2_[0] as CampaignBufferTemp;
            _bufferItem1.data = _loc1_;
            _bufferItemDic[_loc1_.TemplateId] = _bufferItem1;
            _loc1_ = _loc2_[1] as CampaignBufferTemp;
            _bufferItem2.data = _loc1_;
            _bufferItemDic[_loc1_.TemplateId] = _bufferItem2;
            _loc1_ = _loc2_[2] as CampaignBufferTemp;
            _bufferItem3.data = _loc1_;
            _bufferItemDic[_loc1_.TemplateId] = _bufferItem3;
            _loc1_ = _loc2_[3] as CampaignBufferTemp;
            _bufferItem4.data = _loc1_;
            _bufferItemDic[_loc1_.TemplateId] = _bufferItem4;
            _loc1_ = _loc2_[4] as CampaignBufferTemp;
            _bufferItem5.data = _loc1_;
            _bufferItemDic[_loc1_.TemplateId] = _bufferItem5;
         }
      }
      
      private function uninitView() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_titleImg)
         {
            ObjectUtils.disposeObject(_titleImg);
         }
         _titleImg = null;
         if(_rankListTxt)
         {
            ObjectUtils.disposeObject(_rankListTxt);
         }
         _rankListTxt = null;
         if(_infoTeamTxt)
         {
            ObjectUtils.disposeObject(_infoTeamTxt);
         }
         _infoTeamTxt = null;
         if(_infoTeamImg)
         {
            ObjectUtils.disposeObject(_infoTeamImg);
         }
         _infoTeamImg = null;
         if(_infoStateTxt)
         {
            ObjectUtils.disposeObject(_infoStateTxt);
         }
         _infoStateTxt = null;
         if(_infoStateValueTxt)
         {
            ObjectUtils.disposeObject(_infoStateValueTxt);
         }
         _infoStateValueTxt = null;
         if(_infoKillTxt)
         {
            ObjectUtils.disposeObject(_infoKillTxt);
         }
         _infoKillTxt = null;
         if(_infoKillValueBg)
         {
            ObjectUtils.disposeObject(_infoKillValueBg);
         }
         _infoKillValueBg = null;
         if(_infoKillValueTxt)
         {
            ObjectUtils.disposeObject(_infoKillValueTxt);
         }
         _infoKillValueTxt = null;
         if(_infoExchangeTxt)
         {
            ObjectUtils.disposeObject(_infoExchangeTxt);
         }
         _infoExchangeTxt = null;
         if(_infoExchangeValueBg)
         {
            ObjectUtils.disposeObject(_infoExchangeValueBg);
         }
         _infoExchangeValueBg = null;
         if(_infoExchangeValueTxt)
         {
            ObjectUtils.disposeObject(_infoExchangeValueTxt);
         }
         _infoExchangeValueTxt = null;
         if(_infoScoreTxt)
         {
            ObjectUtils.disposeObject(_infoScoreTxt);
         }
         _infoScoreTxt = null;
         if(_infoScoreValueBg)
         {
            ObjectUtils.disposeObject(_infoScoreValueBg);
         }
         _infoScoreValueBg = null;
         if(_infoScoreValueTxt)
         {
            ObjectUtils.disposeObject(_infoScoreValueTxt);
         }
         _infoScoreValueTxt = null;
         if(_bufferItem1)
         {
            ObjectUtils.disposeObject(_bufferItem1);
         }
         _bufferItem1 = null;
         if(_bufferItem2)
         {
            ObjectUtils.disposeObject(_bufferItem2);
         }
         _bufferItem2 = null;
         if(_bufferItem3)
         {
            ObjectUtils.disposeObject(_bufferItem3);
         }
         _bufferItem3 = null;
         if(_bufferItem4)
         {
            ObjectUtils.disposeObject(_bufferItem4);
         }
         _bufferItem4 = null;
         if(_bufferItem5)
         {
            ObjectUtils.disposeObject(_bufferItem5);
         }
         _bufferItem5 = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _controller = null;
         _model = null;
      }
      
      private function addEvent() : void
      {
         _model.addEventListener("SELF_INFO_UPDATE",__selfInfoUpdateHandler);
         _rankListTxt.addEventListener("click",__onLinkHandler);
      }
      
      private function removeEvent() : void
      {
         _model.removeEventListener("SELF_INFO_UPDATE",__selfInfoUpdateHandler);
         _rankListTxt.removeEventListener("click",__onLinkHandler);
      }
      
      private function __onLinkHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("daylight",1);
      }
      
      private function __selfInfoUpdateHandler(param1:DayLightEvent) : void
      {
         refreshView();
      }
      
      public function refreshView() : void
      {
         var _loc2_:Array = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:String = null;
         var _loc8_:Array = null;
         var _loc1_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:DayLightBufferItemView = null;
         if(_model.selfInfo)
         {
            _infoTeamImg.setFrame(_model.selfInfo.team);
            switch(int(_model.selfInfo.state))
            {
               case 0:
                  _infoStateValueTxt.text = LanguageMgr.GetTranslation("sandbox.daylight.DayLightRightView.stateTxt01");
                  _infoStateValueTxt.setFrame(1);
                  break;
               case 1:
                  _infoStateValueTxt.text = LanguageMgr.GetTranslation("sandbox.daylight.DayLightRightView.stateTxt02");
                  _infoStateValueTxt.setFrame(1);
                  break;
               case 2:
                  _infoStateValueTxt.text = LanguageMgr.GetTranslation("sandbox.daylight.DayLightRightView.stateTxt03");
                  _infoStateValueTxt.setFrame(3);
                  break;
               case 3:
                  _infoStateValueTxt.text = LanguageMgr.GetTranslation("sandbox.daylight.DayLightRightView.stateTxt04");
                  _infoStateValueTxt.setFrame(2);
            }
            _infoKillValueTxt.text = _model.selfInfo.repelCount.toString();
            _infoExchangeValueTxt.text = _model.selfInfo.remainCount.toString();
            _infoScoreValueTxt.text = _model.selfInfo.score.toString();
            if(_model.selfInfo.skills)
            {
               _loc2_ = _model.selfInfo.skills.split("|");
               _loc4_ = 0;
               _loc3_ = int(_loc2_.length);
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  _loc7_ = String(_loc2_[_loc4_]);
                  _loc8_ = _loc7_.split(",");
                  _loc1_ = int(_loc8_[0]);
                  _loc6_ = int(_loc8_[1]);
                  _loc5_ = _bufferItemDic[_loc1_];
                  if(_loc5_)
                  {
                     _loc5_.count = _loc6_;
                  }
                  _loc4_++;
               }
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

