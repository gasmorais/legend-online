package avenger.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import manager.LanguageMgr;
   import mvc.module.avenger.AvengerDevilArmorHoleInfo;
   import yishi.datas.templates.AvengerCommonTempInfo;
   import yishi.utils.NumberViewUtils;
   
   public class AvengerDevilArmorCarveItem extends Component
   {
      
      private var _bg:MutipleImage;
      
      private var _curImage:ScaleFrameImage;
      
      private var _numBit:BitmapData;
      
      private var _gradeCon:Component;
      
      private var _attackText:FilterFrameText;
      
      private var _liveText:FilterFrameText;
      
      private var _defenceText:FilterFrameText;
      
      private var _magicDefenceText:FilterFrameText;
      
      private var type:int;
      
      private var data:AvengerDevilArmorHoleInfo;
      
      public function AvengerDevilArmorCarveItem(param1:int)
      {
         super();
         type = param1;
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorCarveItem.bg");
         _curImage = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorCarveItem.curImage");
         _numBit = ComponentFactory.Instance.creatBitmapData("asset.Avenger.numBmd");
         _gradeCon = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorCarveItem.gradeCon");
         _attackText = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorCarveItem.attackText");
         _liveText = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorCarveItem.liveText");
         _defenceText = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorCarveItem.defenceText");
         _magicDefenceText = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorCarveItem.magicDefenceText");
         addChild(_bg);
         addChild(_curImage);
         addChild(_gradeCon);
         addChild(_attackText);
         addChild(_liveText);
         addChild(_defenceText);
         addChild(_magicDefenceText);
         if(type == 1)
         {
            _curImage.x = 40;
         }
         _curImage.setFrame(type);
      }
      
      public function setPropData(param1:AvengerDevilArmorHoleInfo) : void
      {
         var _loc3_:int = 0;
         var _loc2_:AvengerCommonTempInfo = null;
         data = param1;
         if(!data)
         {
            return;
         }
         if(type == 1)
         {
            _loc3_ = int(data.grade);
            _loc2_ = data.tempInfo;
         }
         else
         {
            _loc3_ = data.grade + 1;
            _loc2_ = data.nextTempInfo;
         }
         NumberViewUtils.refreshValue(_loc3_,_gradeCon,_numBit,14,18,11,14,"0123456789");
         if(_loc2_)
         {
            _attackText.text = LanguageMgr.GetTranslation("AvengerBodyPropItem.propText11",_loc2_.PhyAttack);
            _defenceText.text = LanguageMgr.GetTranslation("AvengerBodyPropItem.propText12",_loc2_.PhyDefence);
            _magicDefenceText.text = LanguageMgr.GetTranslation("AvengerBodyPropItem.propText13",_loc2_.MagDefence);
            _liveText.text = LanguageMgr.GetTranslation("AvengerBodyPropItem.propText14",_loc2_.Health);
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_curImage);
         _curImage = null;
         ObjectUtils.disposeObject(_gradeCon);
         _gradeCon = null;
         ObjectUtils.disposeObject(_numBit);
         _numBit = null;
         ObjectUtils.disposeObject(_attackText);
         _attackText = null;
         ObjectUtils.disposeObject(_liveText);
         _liveText = null;
         ObjectUtils.disposeObject(_defenceText);
         _defenceText = null;
         ObjectUtils.disposeObject(_magicDefenceText);
         _magicDefenceText = null;
         super.dispose();
      }
   }
}

