package stelesys.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.templates.StelaResistTemplateInfo;
   import yishi.filter.UIFilter;
   
   public class StelesysIntensifyAddItem extends Sprite
   {
      
      private var _bg:Bitmap;
      
      private var _graySp:Sprite;
      
      private var _att1:StelesysNameAndValueTxt;
      
      private var _att2:StelesysNameAndValueTxt;
      
      private var _lock:Bitmap;
      
      private var _lockTxt:FilterFrameText;
      
      private var _gray:Array;
      
      private var _isLock:Boolean;
      
      private var _data:StelaResistTemplateInfo;
      
      public function StelesysIntensifyAddItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.stelesys.intensify.attBg");
         _lock = ComponentFactory.Instance.creatBitmap("asset.stelesys.RefreshBagCellComposeLock");
         _lockTxt = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.intensifyLockTxt");
         _att1 = ComponentFactory.Instance.creatCustomObject("stelesys.intensify.addAtt1",["ui.stelesys.attNameTxt","ui.stelesys.attValueTxt"]);
         _att2 = ComponentFactory.Instance.creatCustomObject("stelesys.intensify.addAtt2",["ui.stelesys.attNameTxt","ui.stelesys.attValueTxt"]);
         _graySp = new Sprite();
         addChild(_graySp);
         addChild(_lock);
         addChild(_lockTxt);
         _graySp.addChild(_bg);
         _graySp.addChild(_att1);
         _graySp.addChild(_att2);
         _lock.visible = false;
         _gray = [UIFilter.getGrayFilter()];
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_lock);
         _lock = null;
         ObjectUtils.disposeObject(_lockTxt);
         _lockTxt = null;
         ObjectUtils.disposeObject(_att1);
         _att1 = null;
         ObjectUtils.disposeObject(_att2);
         _att2 = null;
         ObjectUtils.disposeObject(_graySp);
         _graySp = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _gray = null;
         _data = null;
      }
      
      public function set isLock(param1:Boolean) : void
      {
         _isLock = param1;
         if(_isLock)
         {
            _graySp.filters = _gray;
            _lock.visible = true;
            _lockTxt.visible = true;
         }
         else
         {
            _graySp.filters = null;
            _lock.visible = false;
            _lockTxt.visible = false;
         }
      }
      
      public function set data(param1:StelaResistTemplateInfo) : void
      {
         _data = param1;
         if(_data)
         {
            visible = true;
            _att1.nameTxt = "ReduceResiAgainst";
            _att1.valueTxt = _data.skillProTempInfo.ReduceResiAgainst;
            _att2.nameTxt = "ResiPenetrate";
            _att2.valueTxt = _data.skillProTempInfo.ResiPenetrate;
            _lockTxt.text = LanguageMgr.GetTranslation("stela.need.lv",_data.StrengthLevel);
         }
         else
         {
            visible = false;
         }
      }
   }
}

