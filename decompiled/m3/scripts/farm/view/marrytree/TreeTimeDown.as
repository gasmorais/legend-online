package farm.view.marrytree
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import mvc.module.marry.MarriageGodTreeInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   
   public class TreeTimeDown extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _progress:MovieClip;
      
      public function TreeTimeDown()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         tipStyle = "yishi.view.tips.TimeDownTip";
         tipDirctions = "7,5,4,6";
         isFollowMouse = false;
         _bg = ComponentFactory.Instance.creatBitmap("asset.farm.marryCircleBack");
         _progress = ClassUtils.CreatInstance("asset.farm.marryCircleIcon") as MovieClip;
         addChild(_bg);
         addChild(_progress);
      }
      
      public function setProgress(param1:Number, param2:Number) : void
      {
         var _loc3_:int = param1 / param2 * 50;
         if(_loc3_ > 50)
         {
            _loc3_ = 50;
         }
         if(_loc3_ < 1)
         {
            _loc3_ = 1;
         }
         _progress.gotoAndStop(_loc3_);
         tipData = [LanguageMgr.GetTranslation("farm.view.marrytree.TreeTimeDown.tips"),DateFormatter.parse(godTreeInfo.treeEarningDate,"YYYY-MM-DD hh:mm:ss").time / 1000 + 43200 - playerModel.sysCurTimeBySecond];
      }
      
      private function get godTreeInfo() : MarriageGodTreeInfo
      {
         return MarryManager.instance.model.marriageData.godTreeInfo;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeViolentMc(_progress);
         _progress = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function drawSector(param1:Shape, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:uint = 0) : void
      {
         var _loc8_:int = 0;
         var _loc10_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc14_:Number = NaN;
         param1.graphics.clear();
         param1.graphics.beginFill(param7,50);
         param1.graphics.lineStyle(5,param7);
         param1.graphics.moveTo(param2,param3);
         param5 = Math.abs(param5) > 360 ? 360 : param5;
         var _loc11_:Number = Math.ceil(Math.abs(param5) / 45);
         var _loc9_:Number = param5 / _loc11_;
         _loc9_ = _loc9_ * 3.141592653589793 / 180;
         param6 = param6 * 3.141592653589793 / 180;
         param1.graphics.lineTo(param2 + param4 * Math.cos(param6),param3 + param4 * Math.sin(param6));
         _loc8_ = 0;
         while(_loc8_ < _loc11_)
         {
            param6 += _loc9_;
            _loc10_ = param6 - _loc9_ / 2;
            _loc13_ = param2 + param4 / Math.cos(_loc9_ / 2) * Math.cos(_loc10_);
            _loc15_ = param3 + param4 / Math.cos(_loc9_ / 2) * Math.cos(_loc10_);
            _loc12_ = param2 + param4 * Math.cos(param6);
            _loc14_ = param3 + param4 * Math.sin(param6);
            param1.graphics.curveTo(_loc13_,_loc15_,_loc12_,_loc14_);
            _loc8_++;
         }
         if(param5 != 360)
         {
            param1.graphics.lineTo(param2,param3);
         }
         param1.graphics.endFill();
      }
   }
}

