package apex.award
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import mvc.module.apex.ApexBetPlayerData;
   
   public class ApexAwardListItem extends Component
   {
      
      private var _txtAwardListItemPlayerName:FilterFrameText;
      
      private var _txtAwardListItemRank:FilterFrameText;
      
      private var _txtAwardListItemArea:FilterFrameText;
      
      private var _bit0:Bitmap;
      
      public function ApexAwardListItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _txtAwardListItemPlayerName = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtAwardListItemPlayerName");
         _txtAwardListItemRank = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtAwardListItemRank");
         _txtAwardListItemArea = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtAwardListItemArea");
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.apex.award.line");
         addChild(_txtAwardListItemPlayerName);
         addChild(_txtAwardListItemRank);
         addChild(_txtAwardListItemArea);
         addChild(_bit0);
         _txtAwardListItemPlayerName.text = "sdfsfdf";
         _txtAwardListItemRank.text = "12";
         _txtAwardListItemArea.text = "合区";
      }
      
      public function set data(param1:ApexBetPlayerData) : void
      {
         _txtAwardListItemPlayerName.text = param1.nickName;
         _txtAwardListItemRank.text = param1.order + "";
         _txtAwardListItemArea.text = param1.serverName;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_txtAwardListItemPlayerName);
         _txtAwardListItemPlayerName = null;
         ObjectUtils.disposeObject(_txtAwardListItemRank);
         _txtAwardListItemRank = null;
         ObjectUtils.disposeObject(_txtAwardListItemArea);
         _txtAwardListItemArea = null;
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

