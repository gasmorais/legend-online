package warsoultower
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.warsoultower.WarSoulTowerModel;
   import yishi.datas.templates.WarSoulTowerLevelTempInfo;
   import yishi.manager.WarSoulTowerManager;
   
   public class WarSoulTowerLevelItem extends Component
   {
      
      private var _levelTxt:FilterFrameText;
      
      private var _iconBg:ScaleFrameImage;
      
      private var _icon:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _data:WarSoulTowerLevelTempInfo;
      
      public function WarSoulTowerLevelItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerLevelItem.levelTxt");
         _iconBg = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerLevelItem.iconBg");
         _icon = ComponentFactory.Instance.creatBitmap("asset.warSoulTowerLevelItem.icon");
         _txt = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerLevelItem.txt");
         addChild(_levelTxt);
         addChild(_iconBg);
         addChild(_icon);
         addChild(_txt);
      }
      
      public function set data(param1:WarSoulTowerLevelTempInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            return;
         }
         _levelTxt.text = LanguageMgr.GetTranslation("warSoulTowerItem.levelTxt.text",_data.LevelId);
         var _loc2_:int = int(model.getState(_data.LevelId));
         _iconBg.setFrame(_loc2_);
         _txt.text = param1.NeedArmourValue.toString();
      }
      
      private function get model() : WarSoulTowerModel
      {
         return WarSoulTowerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeObject(_iconBg);
         _iconBg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         super.dispose();
      }
   }
}

