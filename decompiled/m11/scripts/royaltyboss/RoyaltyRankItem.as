package royaltyboss
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import mvc.module.royaltyboss.RoyaltyRankInfo;
   
   public class RoyaltyRankItem extends Component
   {
      
      private var _rankTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _royaltyLevelTxt:FilterFrameText;
      
      private var _bossLevelTxt:FilterFrameText;
      
      private var _line:Bitmap;
      
      public function RoyaltyRankItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("royaltyRankItem.rankTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("royaltyRankItem.nameTxt");
         _royaltyLevelTxt = ComponentFactory.Instance.creatComponentByStylename("royaltyRankItem.royaltyLevelTxt");
         _bossLevelTxt = ComponentFactory.Instance.creatComponentByStylename("royaltyRankItem.bossLevelTxt");
         _line = ComponentFactory.Instance.creatBitmap("asset.RoyaltyRankItem.line");
         addChild(_rankTxt);
         addChild(_nameTxt);
         addChild(_royaltyLevelTxt);
         addChild(_bossLevelTxt);
         addChild(_line);
      }
      
      public function set data(param1:RoyaltyRankInfo) : void
      {
         if(param1)
         {
            _rankTxt.text = param1.Order.toString();
            _nameTxt.text = param1.nickName;
            _royaltyLevelTxt.text = param1.royaltyLevel.toString();
            _bossLevelTxt.text = param1.bossLevel.toString();
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_royaltyLevelTxt);
         _royaltyLevelTxt = null;
         ObjectUtils.disposeObject(_bossLevelTxt);
         _bossLevelTxt = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

