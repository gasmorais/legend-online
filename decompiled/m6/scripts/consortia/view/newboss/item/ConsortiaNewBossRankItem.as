package consortia.view.newboss.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.consortia.ConsortiaNewBossRankInfo;
   
   public class ConsortiaNewBossRankItem extends Component
   {
      
      private var _rankImg:ScaleFrameImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _userNameTxt:FilterFrameText;
      
      private var _damageTxt:FilterFrameText;
      
      private var _spliteImg:Image;
      
      private var _data:ConsortiaNewBossRankInfo;
      
      public function ConsortiaNewBossRankItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _rankImg = ComponentFactory.Instance.creatComponentByStylename("consortiaNewBossRankItem.rankImg");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("consortiaNewBossRankItem.rankTxt");
         _userNameTxt = ComponentFactory.Instance.creatComponentByStylename("consortiaNewBossRankItem.userNameTxt");
         _damageTxt = ComponentFactory.Instance.creatComponentByStylename("consortiaNewBossRankItem.damageTxt");
         _spliteImg = ComponentFactory.Instance.creatComponentByStylename("consortiaNewBossRankItem.spliteImg");
         addChild(_rankImg);
         addChild(_rankTxt);
         addChild(_userNameTxt);
         addChild(_damageTxt);
         addChild(_spliteImg);
      }
      
      public function set data(param1:ConsortiaNewBossRankInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _userNameTxt.text = _data.nickName;
            _damageTxt.text = _data.damage.toString();
            if(_data.rank > 3)
            {
               _rankImg.visible = false;
               _rankTxt.text = _data.rank.toString();
            }
            else
            {
               _rankImg.visible = true;
               _rankImg.setFrame(_data.rank);
               _rankTxt.text = "";
            }
         }
         else
         {
            _rankImg.visible = false;
            _rankTxt.text = "";
            _userNameTxt.text = "";
            _userNameTxt.text = "";
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_rankImg);
         _rankImg = null;
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_userNameTxt);
         _userNameTxt = null;
         ObjectUtils.disposeObject(_damageTxt);
         _damageTxt = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

