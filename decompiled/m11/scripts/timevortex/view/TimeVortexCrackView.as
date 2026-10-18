package timevortex.view
{
   import com.pickgliss.effect.AdjustColor;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.TimeVortexManager;
   import mvc.controler.TimeVortexController;
   import mvc.module.selectcampaign.CampaignAreaInfo;
   import mvc.module.timevortex.TimeVortexModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   
   public class TimeVortexCrackView extends Sprite implements Disposeable
   {
      
      private static const CRACK_ID:int = 0;
      
      private static const HIT_AREA_CACHE:Dictionary = new Dictionary();
      
      private var _viewPoint:Component;
      
      private var _nameTxt:GradientText;
      
      private var _crackEffect:MovieClip;
      
      private var _scaleBack:MovieClip;
      
      private var _adjustColorFilter:ColorMatrixFilter;
      
      private var _glowFilter:GlowFilter;
      
      private var _data:CampaignAreaInfo;
      
      private var _model:TimeVortexModel = TimeVortexManager.instance.model;
      
      private var _controller:TimeVortexController = FrameControllerManager.instance.timeVortexController;
      
      private var _playerInfo:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
      
      private var _hitArea:Sprite;
      
      private var _hitBitmap:Bitmap;
      
      public function TimeVortexCrackView(param1:MovieClip)
      {
         super();
         _crackEffect = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _viewPoint = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexPointView.mapPoint");
         _scaleBack = ComponentFactory.Instance.creatCustomObject("timevortex.TimeVortexPointView.scaleBack");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexPointView.nameTxt");
         _nameTxt.text = LanguageMgr.GetTranslation("timevortex.TimeVortexCrackFrame.Title");
         _nameTxt.width = _nameTxt.textWidth + 10;
         _scaleBack.width = _nameTxt.width + 30;
         _nameTxt.x = -_nameTxt.width * 0.5;
         _scaleBack.x = _nameTxt.x - 15;
         _scaleBack.y = -5;
         _viewPoint.addChild(_crackEffect);
         _viewPoint.addChild(_scaleBack);
         _viewPoint.addChild(_nameTxt);
         addChild(_viewPoint);
         var _loc1_:AdjustColor = new AdjustColor();
         _loc1_.brightness = 17;
         _loc1_.contrast = 8;
         _loc1_.hue = 0;
         _loc1_.saturation = 0;
         _adjustColorFilter = new ColorMatrixFilter(_loc1_.CalculateFinalFlatArray());
         _glowFilter = new GlowFilter(16639897,1,10,10,1.3);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeViolentMc(_viewPoint);
         _viewPoint = null;
         ObjectUtils.disposeViolentMc(_crackEffect);
         _crackEffect = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeViolentMc(_scaleBack);
         _scaleBack = null;
         ObjectUtils.disposeObject(_adjustColorFilter);
         _adjustColorFilter = null;
         ObjectUtils.disposeObject(_glowFilter);
         _glowFilter = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _adjustColorFilter = null;
         _glowFilter = null;
         _model = null;
         _controller = null;
         _playerInfo = null;
         _data = null;
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__mouseOverHandler);
         addEventListener("mouseOut",__mouseOutHandler);
         addEventListener("click",__mouseClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__mouseOverHandler);
         removeEventListener("mouseOut",__mouseOutHandler);
         removeEventListener("click",__mouseClickHandler);
      }
      
      private function __mouseClickHandler(param1:MouseEvent) : void
      {
         _model.selectedCrack = _data;
         TimeVortexManager.instance.lookUpCrackSingle(_data.campaignId);
         _controller.openCrackFrame();
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         if(_crackEffect)
         {
            _crackEffect.filters = [_adjustColorFilter,_glowFilter];
         }
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         if(_crackEffect)
         {
            _crackEffect.filters = null;
         }
      }
      
      private function refreshView() : void
      {
         _crackEffect.gotoAndStop(1);
         if(!_data)
         {
            visible = false;
            return;
         }
         updateHitArea();
         visible = true;
         mouseEnabled = true;
         buttonMode = true;
      }
      
      private function updateHitArea() : void
      {
         var _loc7_:BitmapData = null;
         var _loc5_:Rectangle = null;
         var _loc6_:Matrix = null;
         var _loc1_:Object = null;
         var _loc4_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:DisplayObject = _crackEffect;
         if(_loc3_)
         {
            if(HIT_AREA_CACHE[0])
            {
               _loc1_ = HIT_AREA_CACHE[0];
               _hitArea = _loc1_["hitArea"];
               _loc4_ = Number(_loc1_["posX"]);
               _loc2_ = Number(_loc1_["posY"]);
               _loc7_ = _loc1_["bitData"];
            }
            else
            {
               _loc5_ = _loc3_.getBounds(_loc3_);
               _loc6_ = new Matrix();
               _loc7_ = new BitmapData(_loc5_.width + 10,_loc5_.height,true,0);
               _loc6_.translate(-_loc5_.x,-_loc5_.y);
               _loc7_.draw(_loc3_,_loc6_);
               _hitArea = DisplayUtils.getHitArea(_loc7_,5);
               _loc4_ = _loc3_.x + _loc5_.x;
               _loc2_ = _loc3_.y + _loc5_.y;
               _loc1_ = {};
               _loc1_["hitArea"] = _hitArea;
               _loc1_["posX"] = _loc4_;
               _loc1_["posY"] = _loc2_;
               _loc1_["bitData"] = _loc7_;
               HIT_AREA_CACHE[0] = _loc1_;
            }
            _hitArea.x = _loc4_;
            _hitArea.y = _loc2_;
            hitArea = _hitArea;
            addChild(_hitArea);
         }
      }
      
      public function set data(param1:CampaignAreaInfo) : void
      {
         _data = param1;
         refreshView();
      }
      
      public function get data() : CampaignAreaInfo
      {
         return _data;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

