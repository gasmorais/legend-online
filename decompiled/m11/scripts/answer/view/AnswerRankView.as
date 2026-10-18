package answer.view
{
   import answer.view.base.AnswerRankItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.utils.NumberViewUtils;
   
   public class AnswerRankView extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _bgRect:ScaleBitmapImage;
      
      private var _titleBg:Bitmap;
      
      private var _rankTitleBg:Bitmap;
      
      private var _selfInfoBg:ScaleBitmapImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _rankList:VBox;
      
      private var _selfRank:FilterFrameText;
      
      private var _selfRankValue:FilterFrameText;
      
      private var _selfScore:FilterFrameText;
      
      private var _selfScoreValue:FilterFrameText;
      
      private var _numberPanel:Sprite;
      
      private var _numberBtmData:BitmapData;
      
      private var _line:Bitmap;
      
      public function AnswerRankView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _bgRect = ComponentFactory.Instance.creatComponentByStylename("answer.bgrect");
         _bg = ComponentFactory.Instance.creatBitmap("asset.answer.rank_bg");
         _titleBg = ComponentFactory.Instance.creatBitmap("asset.answer.rank_title");
         _rankTitleBg = ComponentFactory.Instance.creatBitmap("asset.answer.rank_title_bg");
         _selfInfoBg = ComponentFactory.Instance.creatComponentByStylename("answer.selfinfo_bg");
         _rankList = ComponentFactory.Instance.creatComponentByStylename("answer.rankVBox");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("answer.rank.rank_txt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("answer.rank.name_txt");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("answer.rank.score_txt");
         _selfRank = ComponentFactory.Instance.creatComponentByStylename("answer.rank.selfrank_txt");
         _selfRankValue = ComponentFactory.Instance.creatComponentByStylename("answer.rank.selfrankvalue_txt");
         _selfScore = ComponentFactory.Instance.creatComponentByStylename("answer.rank.selfscore_txt");
         _selfScoreValue = ComponentFactory.Instance.creatComponentByStylename("answer.rank.selfscoreV_txt");
         _numberBtmData = ComponentFactory.Instance.creatBitmapData("asset.core.PawnLevelNum_1").clone();
         _numberPanel = ComponentFactory.Instance.creatCustomObject("answer.rank.scorepanel");
         _rankTxt.text = LanguageMgr.GetTranslation("answer.view.rank.rank");
         _selfScore.text = _scoreTxt.text = LanguageMgr.GetTranslation("answer.view.rank.score");
         _nameTxt.text = LanguageMgr.GetTranslation("answer.view.rank.name");
         _selfRank.text = LanguageMgr.GetTranslation("answer.view.rank.selfrank");
         addChild(_bgRect);
         addChild(_bg);
         addChild(_titleBg);
         addChild(_rankTitleBg);
         addChild(_selfInfoBg);
         addChild(_rankList);
         addChild(_rankTxt);
         addChild(_nameTxt);
         addChild(_scoreTxt);
         addChild(_selfRank);
         addChild(_selfScore);
         addChild(_selfRankValue);
         addChild(_selfScoreValue);
         addChild(_numberPanel);
         _loc1_ = 0;
         while(_loc1_ < 9)
         {
            _line = ComponentFactory.Instance.creatBitmap("asset.answer.line");
            _line.x = 5;
            _line.y = _loc1_ * 29 + 94;
            _line.width = 250;
            addChild(_line);
            _loc1_++;
         }
      }
      
      public function set rankData(param1:*) : void
      {
         var _loc4_:int = 0;
         var _loc5_:AnswerRankItem = null;
         var _loc3_:int = 0;
         var _loc2_:Array = param1 as Array;
         _rankList.removeAllChild();
         if(_loc2_)
         {
            _loc4_ = int(_loc2_.length);
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc5_ = new AnswerRankItem();
               _loc5_.setView(_loc2_[_loc3_]["rank"],_loc2_[_loc3_]["nick"],_loc2_[_loc3_]["score"]);
               _rankList.addChild(_loc5_);
               _loc3_++;
            }
         }
      }
      
      public function setSelfRankInfo(param1:int, param2:int, param3:int = 0) : void
      {
         if(param1 <= 40 && param1 > 0)
         {
            _selfRankValue.text = param1 + "";
         }
         else
         {
            _selfRankValue.text = "--";
         }
         NumberViewUtils.refreshValue(param2,_numberPanel,_numberBtmData,19,25,15,19);
      }
      
      public function dispose() : void
      {
      }
   }
}

