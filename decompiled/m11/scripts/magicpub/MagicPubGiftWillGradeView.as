package magicpub
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class MagicPubGiftWillGradeView extends Sprite implements Disposeable
   {
      
      private var _nameGrade:ScaleFrameImage;
      
      private var _topGrade:ScaleFrameImage;
      
      private var _centerGrade:ScaleFrameImage;
      
      private var _downGrade:ScaleFrameImage;
      
      public function MagicPubGiftWillGradeView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _nameGrade = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.nameGrade");
         _topGrade = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.topGrade");
         _centerGrade = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.centerGrade");
         _downGrade = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.downGrade");
         addChild(_nameGrade);
         addChild(_topGrade);
         addChild(_centerGrade);
         addChild(_downGrade);
         setDataGradeAndPos(1,1);
      }
      
      public function setDataGradeAndPos(param1:int, param2:int) : void
      {
         _nameGrade.setFrame(param1);
         _topGrade.visible = false;
         _centerGrade.visible = false;
         _downGrade.visible = false;
         if(param2 == 1)
         {
            _topGrade.visible = true;
            _topGrade.setFrame(param1);
         }
         else if(param2 == 2)
         {
            _centerGrade.visible = true;
            _centerGrade.setFrame(param1);
         }
         else
         {
            _downGrade.visible = true;
            _downGrade.setFrame(param1);
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_nameGrade);
         _nameGrade = null;
         ObjectUtils.disposeObject(_topGrade);
         _topGrade = null;
         ObjectUtils.disposeObject(_centerGrade);
         _centerGrade = null;
         ObjectUtils.disposeObject(_downGrade);
         _downGrade = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

