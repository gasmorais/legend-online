package ylex.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.YLExpedtionManger;
   import mvc.module.ylex.ChildCampInfo;
   import mvc.module.ylex.YLExpedtionModel;
   import yishi.datas.templates.ChildCampTempTempInfo;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.TimeDownView;
   import yishi.view.tips.MessageTipManager;
   
   public class YLExpeditionItem extends Sprite
   {
      
      public var _nodeYD:MovieClip;
      
      public var _ydmcIn:MovieClip;
      
      public var _ydmcComplete:MovieClip;
      
      public var _ydmcIng:MovieClip;
      
      public var _ydmcFight:MovieClip;
      
      public var _maskFlg:Bitmap;
      
      public var _ydNodeDes:FilterFrameText;
      
      private var _buildingFilter:SimpleBuildingFilter;
      
      private var _ydFt:MutipleImage;
      
      private var levelText:FilterFrameText;
      
      private var numberText:FilterFrameText;
      
      private var _time:TimeDownView;
      
      private var _data:ChildCampInfo;
      
      private var _ingFlg:Bitmap;
      
      private const STATE_REST:int = 0;
      
      private const STATE_ING:int = 1;
      
      private const STATE_COMPLETE:int = 2;
      
      private var _stateCount:int;
      
      private var _state:int = -1;
      
      public function YLExpeditionItem()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get stateCount() : int
      {
         return _stateCount;
      }
      
      public function set stateCount(param1:int) : void
      {
         _stateCount = param1;
         if(_stateCount < 0 && _data != null && _data.childId > 0)
         {
            state = 2;
            _stateCount = 0;
         }
      }
      
      private function set state(param1:int) : void
      {
         if(_state == param1)
         {
            return;
         }
         _state = param1;
         switch(_state)
         {
            case 0:
               _ydmcIn.visible = true;
               _ydmcIng.visible = false;
               _ydmcComplete.visible = false;
               _ydNodeDes.text = LanguageMgr.GetTranslation("YLExpeditionItem.ruzhu.restTip");
               _ydNodeDes.setFrame(1);
               break;
            case 1:
               _ydmcIn.visible = false;
               _ydmcIng.visible = true;
               _ydmcComplete.visible = false;
               _ydNodeDes.text = LanguageMgr.GetTranslation("YLExpeditionItem.ruzhu.doingTip");
               _ydNodeDes.setFrame(1);
               break;
            case 2:
               _ydmcIn.visible = false;
               _ydmcIng.visible = false;
               _ydmcComplete.visible = true;
               _ydNodeDes.text = LanguageMgr.GetTranslation("YLExpeditionItem.ruzhu.completeTip");
               _ydNodeDes.setFrame(2);
         }
      }
      
      private function initView() : void
      {
         _nodeYD = ComponentFactory.Instance.creatCustomObject("asset.ylexdition.main.ydMc");
         _ydmcIn = ComponentFactory.Instance.creatCustomObject("asset.ylexdition.node.needDefendMc");
         _ydmcComplete = ComponentFactory.Instance.creatCustomObject("asset.ylexdition.node.defendCompletMc");
         _ydmcIng = ComponentFactory.Instance.creatCustomObject("asset.ylexdition.node.defendingMc");
         _ydmcFight = ComponentFactory.Instance.creatCustomObject("asset.ylexdition.node.ftMc");
         _maskFlg = ComponentFactory.Instance.creatBitmap("asset.ylexdition.main.mask");
         _ydNodeDes = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.ydNodeDes");
         _ydFt = ComponentFactory.Instance.creatComponentByStylename("ui.ylexdition.main.ydft");
         levelText = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedtion.ydlvTxt");
         numberText = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedtion.ydidTxt");
         _time = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedtion.ydid.sneakTime");
         _ingFlg = ComponentFactory.Instance.creatBitmap("asset.ylexpition.ingFlg");
         addChild(_nodeYD);
         addChild(_ydmcIn);
         addChild(_ydmcComplete);
         addChild(_ydmcIng);
         addChild(_ydmcFight);
         addChild(_maskFlg);
         addChild(_ydNodeDes);
         addChild(_ydFt);
         addChild(levelText);
         addChild(numberText);
         addChild(_time);
         addChild(_ingFlg);
         _buildingFilter = new SimpleBuildingFilter();
         _maskFlg.visible = false;
         _ydmcFight.visible = false;
         _ydmcIng.visible = false;
         _ydmcComplete.visible = false;
         _time.visible = false;
         _ingFlg.visible = false;
         _ydNodeDes.text = LanguageMgr.GetTranslation("YLExpeditionItem.ruzhu.restTip");
         _ydNodeDes.setFrame(1);
         numberText.text = "1";
         levelText.text = "(" + LanguageMgr.GetTranslation("public.level2",1) + ")";
      }
      
      public function get data() : ChildCampInfo
      {
         return _data;
      }
      
      public function set data(param1:ChildCampInfo) : void
      {
         _data = param1;
         if(_data != null)
         {
            refreshView();
         }
      }
      
      private function refreshView() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:ChildCampTempTempInfo = null;
         var _loc4_:YLExpedtionModel = null;
         var _loc3_:Number = NaN;
         _maskFlg.visible = _data.isCover == 1 ? true : false;
         _ydmcFight.visible = false;
         _time.visible = false;
         numberText.text = _data.id.toString();
         levelText.text = "(" + LanguageMgr.GetTranslation("public.level2",_data.grade) + ")";
         stateCount = 0;
         if(_data.childId == 0)
         {
            state = 0;
         }
         else
         {
            _loc1_ = currSysTime;
            _loc2_ = TempleteManager.instance.childCampTempCate.getTempByGrade(_data.grade);
            if(_loc1_ > _data.startTime + _loc2_.StationedTime * 1000)
            {
               state = 2;
            }
            else
            {
               state = 1;
               _stateCount = (_data.startTime + _loc2_.StationedTime * 1000 - _loc1_) / 1000;
               if(!_data.isCover)
               {
                  _loc4_ = YLExpedtionManger.instance.model;
                  _loc3_ = _data.sneakTime + _loc4_.sneakTimeCD * 1000;
                  if(_data.sneakTime > 0 && _loc1_ < _loc3_)
                  {
                     _ydmcFight.visible = true;
                     _time.timeCount = (_loc3_ - _loc1_) / 1000;
                     _time.visible = true;
                  }
               }
            }
         }
      }
      
      private function get currSysTime() : Number
      {
         return PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond * 1000;
      }
      
      private function initEvent() : void
      {
         if(_nodeYD.mc_hitArea)
         {
            _nodeYD.mc_hitArea.buttonMode = true;
            _nodeYD.mc_hitArea.addEventListener("click",__ClickHandler);
            _nodeYD.mc_hitArea.addEventListener("mouseOver",__mouseOverHandler);
            _nodeYD.mc_hitArea.addEventListener("mouseOut",__mouseOutHandler);
         }
         _ydmcFight.buttonMode = true;
         _ydmcFight.addEventListener("click",__ClickFightHandler);
         _ydmcIng.buttonMode = true;
         _ydmcIng.addEventListener("click",ingClickHandler);
         _ydmcIng.addEventListener("mouseOver",ingMouseOverHandler);
         _ydmcIng.addEventListener("mouseOut",ingMouseOutHandler);
         _time.addEventListener("timerDown_complete",timeCompleteHandler);
      }
      
      private function removeEvent() : void
      {
         if(_nodeYD.mc_hitArea)
         {
            _nodeYD.mc_hitArea.removeEventListener("click",__ClickHandler);
            _nodeYD.mc_hitArea.removeEventListener("mouseOver",ingMouseOverHandler);
            _nodeYD.mc_hitArea.removeEventListener("mouseOut",ingMouseOutHandler);
         }
         _ydmcFight.removeEventListener("click",__ClickFightHandler);
         _ydmcIng.removeEventListener("click",ingClickHandler);
         _ydmcIng.removeEventListener("mouseOver",ingClickHandler);
         _ydmcIng.removeEventListener("mouseOut",ingClickHandler);
         _time.removeEventListener("timerDown_complete",timeCompleteHandler);
      }
      
      private function timeCompleteHandler(param1:Event) : void
      {
         _ydmcFight.visible = false;
         _time.visible = false;
      }
      
      private function ingClickHandler(param1:MouseEvent) : void
      {
         if(_ydmcFight.visible)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("YLExpeditionItem.fighting"));
            return;
         }
         if(_data.difficulty == 1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ylexpedition.forbit.cover"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("ylexpedition",4,_data);
      }
      
      private function __ClickFightHandler(param1:MouseEvent) : void
      {
         YLExpedtionManger.instance.sendOp(4,_data.id);
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         if(_nodeYD.mc_hitArea)
         {
            _buildingFilter.setBuildingOverFilter(_nodeYD.mc_hitArea);
         }
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         if(_nodeYD.mc_hitArea)
         {
            _buildingFilter.setBuildingOutFilter(_nodeYD.mc_hitArea);
         }
      }
      
      private function ingMouseOverHandler(param1:MouseEvent) : void
      {
         _ingFlg.visible = true;
      }
      
      private function ingMouseOutHandler(param1:MouseEvent) : void
      {
         _ingFlg.visible = false;
      }
      
      private function __ClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("ylexpedition",2,_data);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeViolentMc(_nodeYD);
         _nodeYD = null;
         ObjectUtils.disposeViolentMc(_ydmcIn);
         _ydmcIn = null;
         ObjectUtils.disposeViolentMc(_ydmcComplete);
         _ydmcComplete = null;
         ObjectUtils.disposeViolentMc(_ydmcIng);
         _ydmcIng = null;
         ObjectUtils.disposeViolentMc(_ydmcFight);
         _ydmcFight = null;
         ObjectUtils.disposeObject(_maskFlg);
         _maskFlg = null;
         ObjectUtils.disposeObject(_ydNodeDes);
         _ydNodeDes = null;
         ObjectUtils.disposeObject(_ydFt);
         _ydFt = null;
         ObjectUtils.disposeObject(levelText);
         levelText = null;
         ObjectUtils.disposeObject(numberText);
         numberText = null;
         ObjectUtils.disposeObject(_time);
         _time = null;
         ObjectUtils.disposeObject(_ingFlg);
         _ingFlg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _buildingFilter = null;
         _data = null;
      }
   }
}

