package magicCard
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import mvc.module.card.MagicCardInfo;
   import mvc.module.card.MagicCardModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.MagicCardTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.MagicCardManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class MagicCardCheckFrame extends Frame
   {
      
      private var _data:MagicCardInfo;
      
      private var _bgMC:MovieClip;
      
      private var _curUrl:String;
      
      private var _viewMC:MovieClip;
      
      private var _leftBtn:BaseButton;
      
      private var _rightBtn:BaseButton;
      
      private var _currentPos:int;
      
      private var _lastClickTime:int = 0;
      
      private var _isSelf:Boolean = true;
      
      private var _cardTempInfo:MagicCardTemplateInfo;
      
      public function MagicCardCheckFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("card.CardCheckFrame.title");
         _bgMC = ComponentFactory.Instance.creatCustomObject("magicCardCheck.bgMC");
         _leftBtn = ComponentFactory.Instance.creatComponentByStylename("magicCard.leftBtn");
         _rightBtn = ComponentFactory.Instance.creatComponentByStylename("magicCard.rightBtn");
         addToContent(_bgMC);
         addToContent(_leftBtn);
         addToContent(_rightBtn);
         _leftBtn.tipData = LanguageMgr.GetTranslation("card.CardCheck.Left");
         _rightBtn.tipData = LanguageMgr.GetTranslation("card.CardCheck.Right");
         _bgMC.gotoAndStop(1);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _leftBtn.addEventListener("click",__clickHandler);
         _rightBtn.addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _leftBtn.removeEventListener("click",__clickHandler);
         _rightBtn.removeEventListener("click",__clickHandler);
      }
      
      protected function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:MagicCardInfo = null;
         var _loc5_:int = getTimer();
         if(_loc5_ - _lastClickTime < 600)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _lastClickTime = _loc5_;
         var _loc4_:int = int(TempleteManager.instance.magicCardTemplateCate.getMaxPosByType(_data.types));
         if(_loc4_ == 1)
         {
            _loc2_ = LanguageMgr.GetTranslation("card.CardCheck.notCheck");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         _currentPos = _data.pos;
         switch(param1.currentTarget)
         {
            case _leftBtn:
               if(_currentPos > 1)
               {
                  _currentPos -= 1;
               }
               else if(_currentPos == 1)
               {
                  _currentPos = _loc4_;
               }
               else
               {
                  _currentPos = _loc4_ - 1;
               }
               break;
            case _rightBtn:
               if(_currentPos <= _loc4_ - 1)
               {
                  _currentPos += 1;
               }
               else
               {
                  _currentPos = 1;
               }
         }
         var _loc6_:MagicCardInfo = magicCardModel.getInfoByTypeAndPos(_cardTempInfo.Types,_currentPos);
         if(_loc6_ == null)
         {
            _loc3_ = new MagicCardInfo();
            _loc3_.types = _cardTempInfo.Types;
            _loc3_.grades = 1;
            _loc3_.pos = _currentPos;
            data = _loc3_;
         }
         else
         {
            data = _loc6_;
         }
      }
      
      private function startLoad() : void
      {
         var _loc1_:String = PathManager.getCardSwfPath(_cardTempInfo.Icon);
         _curUrl = _loc1_;
         LoaderManagerII.instance.load(_loc1_,2,0,__onComplete);
      }
      
      private function __onComplete(param1:LoaderInfo, param2:Object) : void
      {
         if(_curUrl != param1.url)
         {
            return;
         }
         if(!_data)
         {
            return;
         }
         if(param2)
         {
            _viewMC = param2 as MovieClip;
            if(_viewMC && _bgMC)
            {
               _bgMC["center"].addChild(_viewMC);
            }
            _bgMC.play();
            _viewMC.gotoAndPlay(1);
            _viewMC.addEventListener("enterFrame",__enterFrameHandler);
         }
      }
      
      protected function __enterFrameHandler(param1:Event) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_.currentFrame == _loc2_.totalFrames)
         {
            _viewMC.gotoAndStop(_loc2_.currentFrame);
            _viewMC.removeEventListener("enterFrame",__enterFrameHandler);
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
      
      public function clean() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onComplete);
         if(_viewMC)
         {
            _viewMC.stop();
            _viewMC.removeEventListener("enterFrame",__enterFrameHandler);
         }
         if(_viewMC && _viewMC.parent)
         {
            _viewMC.parent.removeChild(_viewMC);
         }
         ObjectUtils.disposeViolentMc(_viewMC);
         _viewMC = null;
         _cardTempInfo = null;
         _bgMC.gotoAndStop(1);
      }
      
      public function set data(param1:MagicCardInfo) : void
      {
         var _loc4_:int = 0;
         var _loc5_:SkillTempInfo = null;
         _data = param1;
         if(!_data)
         {
            return;
         }
         clean();
         if(param1.templateId == 0)
         {
            _cardTempInfo = TempleteManager.instance.magicCardTemplateCate.getTempInfoByTypePosGrades(param1.types,param1.pos,param1.grades);
         }
         else
         {
            _cardTempInfo = TempleteManager.instance.magicCardTemplateCate.getInfoByIdAndGardes(param1.templateId,param1.grades);
         }
         if(_cardTempInfo == null)
         {
            return;
         }
         _leftBtn.visible = _rightBtn.visible = magicCardModel.isSelfCheck;
         _bgMC["bgText"]["lv"].defaultTextFormat = getTextFormat();
         if(_cardTempInfo.Profile == 5)
         {
            _bgMC["iconBg"].gotoAndStop(2);
            _bgMC["bgText"]["lv"].text = "";
         }
         else
         {
            _bgMC["iconBg"].gotoAndStop(1);
            _bgMC["bgText"]["lv"].text = LanguageMgr.GetTranslation("public.level2",_data.grades);
         }
         _bgMC["bgText"]["proTxt"].visible = false;
         _bgMC["cardPro"].visible = false;
         _bgMC["cardPro"]["halo"].visible = false;
         _bgMC["bg"].gotoAndStop(_cardTempInfo.Profile);
         _bgMC["bgText"]["cardName"].defaultTextFormat = getTextFormat();
         _bgMC["bgText"]["cardName"].text = _cardTempInfo.TemplateName;
         _bgMC["describeMC"]["describe"].defaultTextFormat = getTextFormat();
         _bgMC["minorMC"]["minor"].defaultTextFormat = getTextFormat();
         _bgMC["minorMC"]["minor"].text = "";
         _bgMC["minorMC"]["minor"].y = _bgMC["minorMC"]["minor"].numLines == 1 ? 7 : 0;
         _bgMC["propertyMC"]["property"].defaultTextFormat = getTextFormat();
         _bgMC["propertyMC"]["property"].text = "";
         var _loc3_:Array = _cardTempInfo.SkillTempIds.split(",");
         var _loc2_:String = "";
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = TempleteManager.instance.getSkillTemplateInfoById(_loc3_[_loc4_]);
            _loc2_ += _loc5_.TemplateName;
            if(_loc4_ < _loc3_.length - 1)
            {
               _loc2_ += ",";
            }
            _loc4_++;
         }
         _bgMC["describeMC"]["describe"].text = _loc2_;
         _bgMC["describeMC"]["describe"].y = (3 - _bgMC["describeMC"]["describe"].numLines) * 11;
         startLoad();
      }
      
      public function getTextFormat() : TextFormat
      {
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.bold = true;
         _loc1_.font = "Arial";
         return _loc1_;
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      public function get magicCardModel() : MagicCardModel
      {
         return MagicCardManager.Instance.cardModel;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         clean();
         removeEvent();
         if(_bgMC)
         {
            _bgMC.stop();
         }
         ObjectUtils.disposeObject(_data);
         _data = null;
         ObjectUtils.disposeObject(_bgMC);
         _bgMC = null;
         ObjectUtils.disposeObject(_leftBtn);
         _leftBtn = null;
         ObjectUtils.disposeObject(_rightBtn);
         _rightBtn = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

