package consortiachess.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.ChessPvpManager;
   import mvc.module.chesspvp.ChessPvpBoardInfo;
   import mvc.module.chesspvp.ChessPvpModel;
   import mvc.module.chesspvp.ChesspvpTeamInfo;
   import yishi.manager.PlayerManager;
   import yishi.view.community.TimeDownView;
   
   public class ChessPvpBattleRTopUI extends Sprite
   {
      
      protected var _infobg:Bitmap;
      
      protected var _rdCnamebg1:ScaleBitmapImage;
      
      protected var _rdCnamebg2:ScaleBitmapImage;
      
      protected var _bTopRCname1:FilterFrameText;
      
      protected var _bTopRCname2:FilterFrameText;
      
      protected var _bTopRCScore1:GradientText;
      
      protected var _bTopRCScore2:GradientText;
      
      protected var _bTopRVs:Image;
      
      protected var _team2:Bitmap;
      
      protected var _team1:Bitmap;
      
      protected var _rTopTbg:Image;
      
      protected var _bRtopTitle:FilterFrameText;
      
      private var _endCd:TimeDownView;
      
      private var _timeCdBg:Bitmap;
      
      public function ChessPvpBattleRTopUI()
      {
         super();
         initView();
         updateView();
      }
      
      protected function initView() : void
      {
         var _loc2_:int = 0;
         _infobg = ComponentFactory.Instance.creatBitmap("asset.chesspvp.b.infobg");
         _rdCnamebg1 = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.bTopRCnamebg1");
         _rdCnamebg2 = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.bTopRCnamebg2");
         _bTopRCname1 = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.bTopRCname1");
         _bTopRCname2 = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.bTopRCname2");
         _bTopRCScore1 = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.bTopRCScore1Gtx");
         _bTopRCScore2 = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.bTopRCScore2Gtx");
         _bTopRVs = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.bTopRVs");
         _team2 = ComponentFactory.Instance.creatBitmap("asset.chesspvp.b.team2");
         _team1 = ComponentFactory.Instance.creatBitmap("asset.chesspvp.b.team1");
         _rTopTbg = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rTopTbg");
         _bRtopTitle = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.bRtopTitle");
         _endCd = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.battleTimeDownCd");
         _timeCdBg = ComponentFactory.Instance.creatBitmap("asset.chesspvp.timeBg");
         addChild(_infobg);
         addChild(_rdCnamebg1);
         addChild(_rdCnamebg2);
         addChild(_bTopRCname1);
         addChild(_bTopRCname2);
         addChild(_bTopRCScore1);
         addChild(_bTopRCScore2);
         addChild(_bTopRVs);
         addChild(_timeCdBg);
         addChild(_endCd);
         addChild(_team2);
         addChild(_team1);
         addChild(_rTopTbg);
         addChild(_bRtopTitle);
         _bRtopTitle.text = LanguageMgr.GetTranslation("chesspvp.battle.rtop");
         var _loc1_:ChessPvpBoardInfo = ChessPvpManager.Instance.model.boradInfo;
         if(_loc1_)
         {
            _loc2_ = (_loc1_.endDate.time - PlayerManager.instance.currentPlayerModel.nowDate) / 1000;
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            _endCd.timeCount = _loc2_;
         }
      }
      
      public function updateView() : void
      {
         var _loc2_:ChesspvpTeamInfo = model.boradInfo.teamDic[1];
         if(_loc2_)
         {
            _bTopRCname1.text = _loc2_.name;
            _bTopRCScore1.text = "" + _loc2_.addScore;
         }
         var _loc1_:ChesspvpTeamInfo = model.boradInfo.teamDic[2];
         if(_loc1_)
         {
            _bTopRCname2.text = _loc1_.name;
            _bTopRCScore2.text = "" + _loc1_.addScore;
         }
      }
      
      private function get model() : ChessPvpModel
      {
         return ChessPvpManager.Instance.model;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_infobg);
         _infobg = null;
         ObjectUtils.disposeObject(_rdCnamebg1);
         _rdCnamebg1 = null;
         ObjectUtils.disposeObject(_rdCnamebg2);
         _rdCnamebg2 = null;
         ObjectUtils.disposeObject(_bTopRCname1);
         _bTopRCname1 = null;
         ObjectUtils.disposeObject(_bTopRCname2);
         _bTopRCname2 = null;
         ObjectUtils.disposeObject(_bTopRCScore1);
         _bTopRCScore1 = null;
         ObjectUtils.disposeObject(_bTopRCScore2);
         _bTopRCScore2 = null;
         ObjectUtils.disposeObject(_bTopRVs);
         _bTopRVs = null;
         ObjectUtils.disposeObject(_team2);
         _team2 = null;
         ObjectUtils.disposeObject(_team1);
         _team1 = null;
         ObjectUtils.disposeObject(_rTopTbg);
         _rTopTbg = null;
         ObjectUtils.disposeObject(_bRtopTitle);
         _bRtopTitle = null;
         ObjectUtils.disposeObject(_endCd);
         _endCd = null;
         ObjectUtils.disposeObject(_timeCdBg);
         _timeCdBg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

