package consortiachess.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import managers.ChessPvpManager;
   import mvc.module.chesspvp.ChessPvpBoardInfo;
   import mvc.module.chesspvp.ChesspvpRoleInfo;
   import mvc.module.chesspvp.ChesspvpTeamInfo;
   
   public class ChesspvpResultUI extends Sprite
   {
      
      protected var _nameSG:Bitmap;
      
      protected var _bg:Bitmap;
      
      protected var _m:Bitmap;
      
      protected var _rzcfbtn:IconButton;
      
      protected var _rzCnamebg1:ScaleBitmapImage;
      
      protected var _rzCnamebg2:ScaleBitmapImage;
      
      protected var _rzCname1:FilterFrameText;
      
      protected var _rzCname2:FilterFrameText;
      
      protected var _rzCScore1:GradientText;
      
      protected var _rzCScore2:GradientText;
      
      protected var _rzVs:Image;
      
      protected var _light:Bitmap;
      
      protected var _rzTitle:ScaleFrameImage;
      
      public function ChesspvpResultUI()
      {
         super();
         initView();
         initData();
      }
      
      protected function initView() : void
      {
         _nameSG = ComponentFactory.Instance.creatBitmap("asset.chesspvp.nameSG");
         _bg = ComponentFactory.Instance.creatBitmap("asset.chesspvp.rz.bg");
         _m = ComponentFactory.Instance.creatBitmap("asset.chesspvp.rz.m");
         _rzcfbtn = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rzcfbtn");
         _rzCnamebg1 = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rzCnamebg1");
         _rzCnamebg2 = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rzCnamebg2");
         _rzCname1 = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rzCname1");
         _rzCname2 = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rzCname2");
         _rzCScore1 = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rzCScore1Gtx");
         _rzCScore2 = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rzCScore2Gtx");
         _rzVs = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rzVs");
         _light = ComponentFactory.Instance.creatBitmap("asset.chesspvp.rz.light");
         _rzTitle = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rzTitle");
         addChild(_nameSG);
         addChild(_bg);
         addChild(_m);
         addChild(_rzcfbtn);
         addChild(_rzCnamebg1);
         addChild(_rzCnamebg2);
         addChild(_rzCname1);
         addChild(_rzCname2);
         addChild(_rzCScore1);
         addChild(_rzCScore2);
         addChild(_rzVs);
         addChild(_light);
         addChild(_rzTitle);
      }
      
      private function initData() : void
      {
         var _loc4_:ChessPvpBoardInfo = ChessPvpManager.Instance.model.boradInfo;
         var _loc2_:ChesspvpRoleInfo = ChessPvpManager.Instance.model.selfInfo;
         var _loc3_:int = 2;
         if(_loc2_.team == 2)
         {
            _loc3_ = 1;
         }
         var _loc1_:int = int(ChessPvpManager.Instance.model.result);
         switch(_loc1_)
         {
            case 0:
               _rzTitle.setFrame(1);
               break;
            case 1:
               _rzTitle.setFrame(2);
               break;
            case 2:
               _rzTitle.setFrame(3);
         }
         var _loc6_:ChesspvpTeamInfo = _loc4_.teamDic[_loc2_.team];
         _rzCname1.text = _loc6_.name;
         _rzCScore1.text = "" + _loc6_.addScore;
         var _loc5_:ChesspvpTeamInfo = _loc4_.teamDic[_loc3_];
         _rzCname2.text = _loc5_.name;
         _rzCScore2.text = "" + _loc5_.addScore;
      }
      
      public function get btn() : IconButton
      {
         return _rzcfbtn;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_nameSG);
         _nameSG = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_m);
         _m = null;
         ObjectUtils.disposeObject(_rzcfbtn);
         _rzcfbtn = null;
         ObjectUtils.disposeObject(_rzCnamebg1);
         _rzCnamebg1 = null;
         ObjectUtils.disposeObject(_rzCnamebg2);
         _rzCnamebg2 = null;
         ObjectUtils.disposeObject(_rzCname1);
         _rzCname1 = null;
         ObjectUtils.disposeObject(_rzCname2);
         _rzCname2 = null;
         ObjectUtils.disposeObject(_rzCScore1);
         _rzCScore1 = null;
         ObjectUtils.disposeObject(_rzCScore2);
         _rzCScore2 = null;
         ObjectUtils.disposeObject(_rzVs);
         _rzVs = null;
         ObjectUtils.disposeObject(_light);
         _light = null;
         ObjectUtils.disposeObject(_rzTitle);
         _rzTitle = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

