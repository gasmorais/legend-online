package singlepass.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.SinglePassManager;
   import mvc.module.singlepass.SinglePassCardInfo;
   import mvc.module.singlepass.SinglePassCardStateInfo;
   import mvc.module.singlepass.SinglePassTipData;
   import yishi.datas.templates.GodArriveData;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class SinglePassCardItemView extends Sprite implements Disposeable
   {
      
      private const QUARD_LEFT:Number = 5;
      
      private const QUARD_RIGHT:Number = 185;
      
      private const JUDGEBG_LEFT:Number = -38;
      
      private const JUDGEBG_RIGHT:Number = 94;
      
      private const JUDGE_LEFT:Number = 23;
      
      private const JUDGE_RIGHT:Number = 155;
      
      private var _bg:Bitmap;
      
      private var _lightBg:Bitmap;
      
      private var _icon:BaseIconView;
      
      private var _guard:ScaleFrameImage;
      
      private var _guardTip:StripView;
      
      private var _reward:Bitmap;
      
      private var _rewardTip:StripView;
      
      private var _judgeBg:Bitmap;
      
      private var _judge:ScaleFrameImage;
      
      private var _turning:Boolean = false;
      
      private var _selected:Boolean = false;
      
      private var _stateInfo:SinglePassCardStateInfo;
      
      private var _colorMatrix:Array;
      
      private var _colorFilter:ColorMatrixFilter;
      
      private var _data:SinglePassCardInfo;
      
      private var _enable:Boolean = false;
      
      private var _cardHitArea:StripView;
      
      public function SinglePassCardItemView()
      {
         super();
         _colorMatrix = [0.2,0,0,0,6.1,0,0.2,0,0,6.1,0,0,0.2,0,6.1,0,0,0,1,0];
         _colorFilter = new ColorMatrixFilter(_colorMatrix);
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.singlepass.CardBgAsset");
         _lightBg = ComponentFactory.Instance.creatBitmap("asset.singlepass.CardLightAsset");
         _icon = ComponentFactory.Instance.creatCustomObject("singlepass.SinglePassCardItemView.Icon");
         _guard = ComponentFactory.Instance.creatComponentByStylename("singlepass.SinglePassCardItemView.Guard");
         _guardTip = ComponentFactory.Instance.creatCustomObject("singlepass.GuardTip");
         _reward = ComponentFactory.Instance.creatBitmap("asset.singlepass.CardRewardAsset");
         _rewardTip = ComponentFactory.Instance.creatCustomObject("singlepass.RewardTip");
         _judgeBg = ComponentFactory.Instance.creatBitmap("asset.singlepass.CardJudgeBgAsset");
         _judge = ComponentFactory.Instance.creatComponentByStylename("singlepass.SinglePassCardItemView.Judge");
         _cardHitArea = ComponentFactory.Instance.creatCustomObject("singlepass.CardHitArea");
         _guardTip.addChild(_guard);
         _rewardTip.addChild(_reward);
         _cardHitArea.addChild(_bg);
         _cardHitArea.addChild(_lightBg);
         _cardHitArea.addChild(_icon);
         _cardHitArea.addChild(_judgeBg);
         _cardHitArea.addChild(_judge);
         addChild(_cardHitArea);
         addChild(_guardTip);
         addChild(_rewardTip);
         _cardHitArea.setHitArea(0,0,_bg.width,_bg.height);
         _judgeBg.visible = false;
         _judge.visible = false;
         _cardHitArea.buttonMode = true;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_lightBg);
         _lightBg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_guard);
         _guard = null;
         ObjectUtils.disposeObject(_guardTip);
         _guardTip = null;
         ObjectUtils.disposeObject(_reward);
         _reward = null;
         ObjectUtils.disposeObject(_rewardTip);
         _rewardTip = null;
         ObjectUtils.disposeObject(_judgeBg);
         _judgeBg = null;
         ObjectUtils.disposeObject(_judge);
         _judge = null;
      }
      
      private function initEvent() : void
      {
         _cardHitArea.addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         _cardHitArea.removeEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(_data && _enable && !turning)
         {
            SinglePassManager.instance.sendRequestSinglePassAttack(_data.tollgate);
         }
      }
      
      private function get showJudge() : Boolean
      {
         if(_data && _data.judge != 0)
         {
            return true;
         }
         return false;
      }
      
      public function get data() : SinglePassCardInfo
      {
         return _data;
      }
      
      public function set data(param1:SinglePassCardInfo) : void
      {
         var _loc4_:GodArriveData = null;
         var _loc6_:SinglePassTipData = null;
         var _loc5_:Array = null;
         var _loc3_:Array = null;
         var _loc2_:Array = null;
         _data = param1;
         if(_data)
         {
            _loc4_ = TempleteManager.instance.godArriveTemplateCate.getGodArriveData(40001,_data.tollgate);
            _loc6_ = new SinglePassTipData();
            _loc5_ = LanguageMgr.GetTranslation("singlepass.view.SinglePassCardItemView.PetTypeList").split("|");
            _loc3_ = TempleteManager.instance.singlePassBossRewardTemplateCate.getBossRewardByTypeAndFloor(0,_data.tollgate);
            _loc2_ = TempleteManager.instance.singlePassBossRewardTemplateCate.getBossRewardByTypeAndFloor(2,_data.tollgate);
            _loc6_.drops1 = _loc3_.concat(_loc2_);
            if(showJudge)
            {
               _judgeBg.visible = true;
               _judge.visible = true;
               _judge.setFrame(_data.judge);
               _loc6_.type = 2;
            }
            else
            {
               _judgeBg.visible = false;
               _judge.visible = false;
               _loc6_.type = 1;
            }
            _guard.setFrame(_loc4_.Param5);
            _icon.icon = IconFactory.getGodArriveBossIcon(40001,_data.tollgate);
            _guardTip.tipData = LanguageMgr.GetTranslation("singlepass.view.SinglePassCardItemView.TipsTxt04",_loc5_[_loc4_.Param5 - 1]);
            _rewardTip.tipData = _loc6_;
         }
      }
      
      public function get turning() : Boolean
      {
         return _turning;
      }
      
      public function set turning(param1:Boolean) : void
      {
         if(_turning != param1)
         {
            _turning = param1;
            refreshViewByTurnFlag();
         }
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(_selected != param1)
         {
            _selected = param1;
            refreshView();
         }
      }
      
      public function get stateInfo() : SinglePassCardStateInfo
      {
         return _stateInfo;
      }
      
      public function set stateInfo(param1:SinglePassCardStateInfo) : void
      {
         if(_stateInfo != param1)
         {
            _stateInfo = param1;
         }
      }
      
      public function refreshViewByState() : void
      {
         this.alpha = _stateInfo.alpha;
         this.x = _stateInfo.x;
         this.y = _stateInfo.y;
         this.scaleX = this.scaleY = _stateInfo.scale;
      }
      
      public function refreshPositionByState() : void
      {
         if(_stateInfo.align == "left")
         {
            _guard.x = 5;
            _reward.x = 5;
            _judgeBg.x = -38;
            _judge.x = 23;
            _cardHitArea.buttonMode = false;
            _enable = false;
         }
         else if(_stateInfo.align == "center")
         {
            _guard.x = 5;
            _reward.x = 5;
            _judgeBg.x = 94;
            _judge.x = 155;
            _cardHitArea.buttonMode = true;
            _enable = true;
         }
         else if(_stateInfo.align == "right")
         {
            _guard.x = 185;
            _reward.x = 185;
            _judgeBg.x = 94;
            _judge.x = 155;
            _cardHitArea.buttonMode = false;
            _enable = false;
         }
      }
      
      private function refreshViewByTurnFlag() : void
      {
         _guard.visible = !_turning;
         _reward.visible = !_turning;
         if(showJudge)
         {
            _judgeBg.visible = !_turning;
            _judge.visible = !_turning;
         }
         else
         {
            _judgeBg.visible = false;
            _judge.visible = false;
         }
         if(_turning)
         {
            _cardHitArea.buttonMode = false;
         }
         else
         {
            refreshPositionByState();
         }
      }
      
      private function refreshView() : void
      {
         _lightBg.visible = _selected;
         _guardTip.mouseEnabled = _guardTip.mouseChildren = _selected;
         _rewardTip.mouseEnabled = _rewardTip.mouseChildren = _selected;
         _cardHitArea.mouseEnabled = _cardHitArea.mouseChildren = _selected;
         if(_selected)
         {
            filters = null;
         }
         else
         {
            filters = [_colorFilter];
         }
      }
      
      override public function get width() : Number
      {
         return _bg.width;
      }
      
      override public function get height() : Number
      {
         return _bg.height;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

