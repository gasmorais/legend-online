package finaldefense.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.CustomBitmap;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.FinalDefenseManager;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.NotificationManager;
   import yishi.view.community.BaseIconView;
   
   public class FinalDefenseRightView extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _indexBg:Bitmap;
      
      private var _pointTxt:FilterFrameText;
      
      private var _pressImg:Bitmap;
      
      private var _maskShape:Shape;
      
      private var _gameIndexImg:ScaleFrameImage;
      
      private var _boxIconArr:Array;
      
      private var _pointImgArr:Array;
      
      private var _boxRewardView:FinalDefenseBoxRewardView;
      
      private const SORCE_ARR:Array = [0,100,500,1500,3000,5000];
      
      private const Y_ARR:Array = [546,498,406,311,219,126,96];
      
      private var _getedImgArr:Array;
      
      public function FinalDefenseRightView()
      {
         super();
         initView();
         addEvent();
         updateView();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc4_:BaseIconView = null;
         var _loc3_:Bitmap = null;
         var _loc1_:CustomBitmap = null;
         _boxIconArr = [];
         _pointImgArr = [];
         _getedImgArr = [];
         _bg = ComponentFactory.Instance.creatBitmap("asset.finaldefense.RightViewBg");
         _indexBg = ComponentFactory.Instance.creatBitmap("asset.finaldefense.RightViewIndexBg");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("finaldefens.pointTxt");
         _pressImg = ComponentFactory.Instance.creatBitmap("asset.finaldefense.RightViewPointPress");
         _maskShape = new Shape();
         _gameIndexImg = ComponentFactory.Instance.creatComponentByStylename("finalDefense.gameIndexImg");
         addChild(_bg);
         addChild(_indexBg);
         addChild(_pointTxt);
         addChild(_pressImg);
         addChild(_gameIndexImg);
         _maskShape.graphics.beginFill(0);
         _maskShape.graphics.drawRect(0,0,_pressImg.width,_pressImg.height);
         _maskShape.graphics.endFill();
         _maskShape.x = _pressImg.x;
         _pressImg.mask = _maskShape;
         addChild(_maskShape);
         _maskShape.y = _pressImg.y + 0.6 * _pressImg.height;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc4_ = ComponentFactory.Instance.creatCustomObject("finaldefense.boxIcon" + _loc2_);
            _loc4_.buttonMode = true;
            _loc4_.icon = ComponentFactory.Instance.creatCustomObject("finaldefense.rightBoxImg");
            addChild(_loc4_);
            _boxIconArr.push(_loc4_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc3_ = ComponentFactory.Instance.creatBitmap("asset.finaldefense.pointImg" + _loc2_);
            addChild(_loc3_);
            _pointImgArr.push(_loc3_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("finaldefense.RightBoxGetedImg" + _loc2_);
            _getedImgArr.push(_loc1_);
            addChild(_loc1_);
            _loc1_.visible = false;
            _loc2_++;
         }
      }
      
      public function updateView() : void
      {
         var _loc6_:int = 0;
         var _loc3_:* = 0;
         var _loc5_:int = 0;
         var _loc4_:Number = NaN;
         var _loc1_:int = int(FinalDefenseManager.ins.model.info.rounds > 5 ? 5 : FinalDefenseManager.ins.model.info.rounds);
         _gameIndexImg.setFrame(_loc1_);
         var _loc2_:int = int(FinalDefenseManager.ins.model.info.score);
         _pointTxt.text = LanguageMgr.GetTranslation("finaldefense.view.pointTxt",_loc2_);
         _loc6_ = 0;
         while(_loc6_ < _boxIconArr.length)
         {
            _boxIconArr[_loc6_].filters = [UIFilter.getBlackFilter()];
            _boxIconArr[_loc6_].removeEventListener("click",onBoxClick);
            _loc6_++;
         }
         _loc6_ = 1;
         while(_loc6_ < SORCE_ARR.length)
         {
            if(_loc2_ >= SORCE_ARR[_loc6_])
            {
               _boxIconArr[_loc6_ - 1].filters = [];
               _boxIconArr[_loc6_ - 1].addEventListener("click",onBoxClick);
            }
            _loc6_++;
         }
         if(_loc2_ > SORCE_ARR[SORCE_ARR.length - 1])
         {
            _maskShape.y = Y_ARR[SORCE_ARR.length];
            return;
         }
         _loc6_ = 0;
         while(_loc6_ < SORCE_ARR.length)
         {
            if(_loc2_ <= SORCE_ARR[_loc6_])
            {
               _loc3_ = _loc6_;
               break;
            }
            _loc6_++;
         }
         _maskShape.y = Y_ARR[_loc3_];
         if(_loc2_ < SORCE_ARR[_loc3_])
         {
            _loc5_ = SORCE_ARR[_loc3_] - _loc2_;
            _loc4_ = _loc5_ / (SORCE_ARR[_loc3_] - SORCE_ARR[_loc3_ - 1]);
            _maskShape.y += _loc4_ * (Y_ARR[_loc3_ - 1] - Y_ARR[_loc3_]);
         }
         var _loc7_:Array = [1,2,4,8,16];
         _loc6_ = 0;
         while(_loc6_ < _getedImgArr.length)
         {
            _getedImgArr[_loc6_].visible = false;
            if((_loc7_[_loc6_] & FinalDefenseManager.ins.model.info.boxTakeMark) > 0)
            {
               _getedImgArr[_loc6_].visible = true;
            }
            _loc6_++;
         }
      }
      
      private function onStageClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(_boxIconArr.indexOf(param1.target) != -1)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _boxIconArr.length)
         {
            if(_boxIconArr[_loc2_].contains(param1.target as DisplayObject))
            {
               return;
            }
            _loc2_++;
         }
         if(param1.target == _boxRewardView)
         {
            return;
         }
         if(_boxRewardView.contains(param1.target as DisplayObject))
         {
            return;
         }
         if(this.contains(_boxRewardView))
         {
            this.removeChild(_boxRewardView);
         }
         StageReferance.stage.removeEventListener("click",onStageClick);
      }
      
      private function addEvent() : void
      {
         var _loc1_:int = 0;
         NotificationManager.instance.addEventListener("FINAL_DEFENSE_INFO",onInfo);
      }
      
      private function onInfo(param1:NotificationEvent) : void
      {
         updateView();
      }
      
      private function onBoxClick(param1:MouseEvent) : void
      {
         if(_boxRewardView == null)
         {
            _boxRewardView = new FinalDefenseBoxRewardView();
         }
         var _loc2_:int = _boxIconArr.indexOf(param1.currentTarget);
         var _loc3_:Array = [1,2,4,8,16];
         _boxRewardView.boxId = _loc3_[_loc2_];
         _boxRewardView.x = param1.currentTarget.x - _boxRewardView.width;
         _boxRewardView.y = param1.currentTarget.y - 20;
         addChild(_boxRewardView);
         StageReferance.stage.addEventListener("click",onStageClick);
      }
      
      private function removeEvent() : void
      {
         var _loc1_:int = 0;
         if(_boxIconArr != null)
         {
            _loc1_ = 0;
            while(_loc1_ < _boxIconArr.length)
            {
               _boxIconArr[_loc1_].removeEventListener("click",onBoxClick);
               _loc1_++;
            }
         }
         StageReferance.stage.removeEventListener("click",onStageClick);
         NotificationManager.instance.removeEventListener("FINAL_DEFENSE_INFO",onInfo);
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_indexBg);
         _indexBg = null;
         ObjectUtils.disposeObject(_pointTxt);
         _pointTxt = null;
         ObjectUtils.disposeObject(_pressImg);
         _pressImg = null;
         ObjectUtils.disposeObject(_maskShape);
         _maskShape = null;
         ObjectUtils.disposeObject(_gameIndexImg);
         _gameIndexImg = null;
         ObjectUtils.disposeObject(_boxRewardView);
         _boxRewardView = null;
         if(_boxIconArr != null)
         {
            _loc1_ = 0;
            while(_loc1_ < _boxIconArr.length)
            {
               ObjectUtils.disposeObject(_boxIconArr[_loc1_]);
               _boxIconArr[_loc1_] = null;
               _loc1_++;
            }
            _boxIconArr = null;
         }
         if(_pointImgArr != null)
         {
            _loc1_ = 0;
            while(_loc1_ < _pointImgArr.length)
            {
               ObjectUtils.disposeObject(_pointImgArr[_loc1_]);
               _pointImgArr[_loc1_] = null;
               _loc1_++;
            }
            _pointImgArr = null;
         }
         if(_getedImgArr != null)
         {
            _loc1_ = 0;
            while(_loc1_ < _getedImgArr.length)
            {
               ObjectUtils.disposeObject(_getedImgArr[_loc1_]);
               _getedImgArr[_loc1_] = null;
               _loc1_++;
            }
            _getedImgArr = null;
         }
         super.dispose();
      }
   }
}

