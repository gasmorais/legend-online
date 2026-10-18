package map.campaign.mediator.mapview
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import mvc.module.consortia.ConsortiaUserInfo;
   import yishi.utils.NumberViewUtils;
   
   public class ConsortiaSecretSortItem extends Component
   {
      
      private var rankImage:ScaleFrameImage;
      
      private var numberBitmap:BitmapData;
      
      private var sortContiner:Component;
      
      private var nameText:FilterFrameText;
      
      private var numberBitmap2:BitmapData;
      
      private var scoreContiner:Component;
      
      private var _data:ConsortiaUserInfo;
      
      public function ConsortiaSecretSortItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         rankImage = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSecretSortItem.rankImage");
         numberBitmap = ComponentFactory.Instance.creatBitmapData("asset.ConsortiaSecretSortItem.numberBitmap");
         sortContiner = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSecretSortItem.sortContiner");
         nameText = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSecretSortItem.nameText");
         numberBitmap2 = ComponentFactory.Instance.creatBitmapData("asset.ConsortiaSecretSortItem.numberBitmap2");
         scoreContiner = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSecretSortItem.scoreContiner");
         addChild(rankImage);
         addChild(sortContiner);
         addChild(nameText);
         addChild(scoreContiner);
      }
      
      public function set data(param1:ConsortiaUserInfo) : void
      {
         _data = param1;
         clean();
         if(_data)
         {
            if(_data.secretOrder >= 1 && _data.secretOrder <= 3)
            {
               rankImage.visible = true;
               rankImage.setFrame(_data.secretOrder);
            }
            else
            {
               sortContiner.visible = true;
               NumberViewUtils.refreshValue(_data.secretOrder,sortContiner,numberBitmap,12,13,10,12,"0123456789");
            }
            scoreContiner.visible = true;
            nameText.text = _data.nickName;
            NumberViewUtils.refreshValue(_data.secretScore,scoreContiner,numberBitmap2,12,16,10,12,"0123456789");
         }
      }
      
      private function clean() : void
      {
         rankImage.visible = false;
         sortContiner.visible = false;
         scoreContiner.visible = false;
         nameText.text = "";
      }
      
      override public function dispose() : void
      {
         if(rankImage)
         {
            ObjectUtils.disposeObject(rankImage);
         }
         rankImage = null;
         if(numberBitmap)
         {
            ObjectUtils.disposeObject(numberBitmap);
         }
         numberBitmap = null;
         if(sortContiner)
         {
            ObjectUtils.disposeObject(sortContiner);
         }
         sortContiner = null;
         if(scoreContiner)
         {
            ObjectUtils.disposeObject(scoreContiner);
         }
         scoreContiner = null;
         if(nameText)
         {
            ObjectUtils.disposeObject(nameText);
         }
         nameText = null;
         super.dispose();
      }
   }
}

