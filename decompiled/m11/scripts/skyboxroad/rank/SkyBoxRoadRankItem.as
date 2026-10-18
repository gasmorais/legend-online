package skyboxroad.rank
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.skyboxroad.SkyboxRoadRankInfo;
   import yishi.utils.DateFormatter;
   
   public class SkyBoxRoadRankItem extends Component
   {
      
      private var _rankImage:ScaleFrameImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _seveTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      public function SkyBoxRoadRankItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _rankImage = ComponentFactory.Instance.creatComponentByStylename("skysecretareaItem.RankNum");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("skysecretarea.rankItemRank");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("skysecretarea.rankItemName");
         _seveTxt = ComponentFactory.Instance.creatComponentByStylename("skysecretarea.rankItemSeve");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("skysecretarea.rankItemTime");
         addChild(_rankImage);
         addChild(_rankTxt);
         addChild(_nameTxt);
         addChild(_timeTxt);
         addChild(_seveTxt);
         _rankImage.setFrame(1);
      }
      
      public function set data(param1:SkyboxRoadRankInfo) : void
      {
         if(!param1)
         {
            return;
         }
         if(param1.showOrder <= 3)
         {
            _rankImage.setFrame(param1.showOrder);
            _rankImage.visible = true;
            _rankTxt.visible = false;
         }
         else
         {
            _rankImage.visible = false;
            _rankTxt.visible = true;
            _rankTxt.text = String(param1.showOrder);
         }
         _nameTxt.text = param1.nickName;
         _seveTxt.text = param1.serverName;
         _timeTxt.text = DateFormatter.getConsortiaCountDate(param1.showTime);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_rankImage);
         _rankImage = null;
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_seveTxt);
         _seveTxt = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

