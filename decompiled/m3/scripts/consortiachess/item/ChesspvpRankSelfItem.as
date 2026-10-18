package consortiachess.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.ChessPvpManager;
   import mvc.module.chesspvp.ChessPvpGroupInfo;
   
   public class ChesspvpRankSelfItem extends Sprite
   {
      
      private var _selfbg:Bitmap;
      
      private var _sortTitle:FilterFrameText;
      
      private var _scoreTitle:FilterFrameText;
      
      private var _sortTxtBg:ScaleLeftRightImage;
      
      private var _sortTxt:FilterFrameText;
      
      private var _scoretTxtBg:ScaleLeftRightImage;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _consortiaName:GradientText;
      
      private var _groupName:GradientText;
      
      public function ChesspvpRankSelfItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _selfbg = ComponentFactory.Instance.creatBitmap("asset.chesspvk.rank.selfBg");
         _sortTitle = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.selfR");
         _scoreTitle = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.selfS");
         _sortTxtBg = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rank.selfRankBg");
         _sortTxt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.selfRn");
         _scoretTxtBg = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rank.selfScoreBg");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.selfSn");
         _consortiaName = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.sortT.GTitleTxt");
         _groupName = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.sortT2.GTitleTxt");
         addChild(_selfbg);
         addChild(_sortTitle);
         addChild(_scoreTitle);
         addChild(_sortTxtBg);
         addChild(_sortTxt);
         addChild(_scoretTxtBg);
         addChild(_scoreTxt);
         addChild(_consortiaName);
         addChild(_groupName);
         _sortTitle.text = LanguageMgr.GetTranslation("chesspvp.rank.cTitle");
         _scoreTitle.text = LanguageMgr.GetTranslation("chesspvp.rank.cScore");
         _consortiaName.text = LanguageMgr.GetTranslation("chesspvp.in.gt");
         var _loc1_:ChessPvpGroupInfo = ChessPvpManager.Instance.model.selfGroupInfo;
         if(_loc1_)
         {
            _sortTxt.text = "" + _loc1_.rank;
            _scoreTxt.text = "" + _loc1_.score;
            if(_loc1_.isSignUp)
            {
               _groupName.text = "(" + LanguageMgr.GetTranslation("chesspvp.in.groupName" + _loc1_.group) + ")";
            }
            else
            {
               _groupName.text = "(" + LanguageMgr.GetTranslation("chesspvp.in.nogroup") + ")";
            }
         }
         else
         {
            _sortTxt.text = "--";
            _scoreTxt.text = "--";
            _groupName.text = "--";
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_selfbg);
         _selfbg = null;
         ObjectUtils.disposeObject(_consortiaName);
         _consortiaName = null;
         ObjectUtils.disposeObject(_groupName);
         _groupName = null;
         ObjectUtils.disposeObject(_sortTitle);
         _sortTitle = null;
         ObjectUtils.disposeObject(_scoreTitle);
         _scoreTitle = null;
         ObjectUtils.disposeObject(_sortTxtBg);
         _sortTxtBg = null;
         ObjectUtils.disposeObject(_sortTxt);
         _sortTxt = null;
         ObjectUtils.disposeObject(_scoretTxtBg);
         _scoretTxtBg = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

