package ancientartifact.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import mvc.module.ancientartifact.AncientArtifactInfo;
   import yishi.datas.templates.ArtifactTemplateInfo;
   import yishi.events.NotificationEvent;
   
   public class AncientStrengthenItem extends Component
   {
      
      private var _template:ArtifactTemplateInfo;
      
      private var _data:AncientArtifactInfo;
      
      private var _index:int;
      
      private var _oldDataValue:int;
      
      private var _dataValue:int;
      
      private var _maxValue:int;
      
      private var _arrowTxt:String = "";
      
      private var _delay:uint;
      
      private var _isFirst:Boolean = true;
      
      private var _redBar:MovieClip;
      
      private var _propertyName:FilterFrameText;
      
      private var _progressTxt:FilterFrameText;
      
      private var _rateTxt:FilterFrameText;
      
      private var _addArrowMc:MovieClip;
      
      private var _minName:Array = ["AttackMin","DefenceMin","MagicAttackMin","MagicDefenceMin","PenetrateMin","ParryMin","LiveMin"];
      
      private var _maxName:Array = ["AttackMax","DefenceMax","MagicAttackMax","MagicDefenceMax","PenetrateMax","ParryMax","LiveMax"];
      
      private var _dataName:Array = ["attack","defences","magicAttack","magicDefences","penetrate","parry","live"];
      
      private var _nameArr:Array = ["40","41","42","43","37","38","39"];
      
      public function AncientStrengthenItem(param1:int)
      {
         super();
         _index = param1;
         initView();
      }
      
      private function initView() : void
      {
         _redBar = ComponentFactory.Instance.creatCustomObject("asset.ancientartifact.redProgressBar");
         _propertyName = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.StrengthenItem.propertyName");
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.redBar.progressTxt");
         _rateTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.StrengthenItem.rateTxt");
         _addArrowMc = ComponentFactory.Instance.creatCustomObject("asset.ancientartifact.AddArrowMc");
         addChild(_redBar);
         addChild(_propertyName);
         addChild(_progressTxt);
         addChild(_rateTxt);
         addChild(_addArrowMc);
         _addArrowMc.gotoAndStop(1);
         _addArrowMc.visible = false;
      }
      
      public function setData(param1:ArtifactTemplateInfo, param2:AncientArtifactInfo, param3:NotificationEvent = null) : void
      {
         var _loc5_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc4_:int = 0;
         var _loc6_:Boolean = false;
         _template = param1;
         _data = param2;
         if(_data)
         {
            _loc8_ = _dataName[_index - 1];
            _loc9_ = int(_data[_loc8_]);
            _dataValue = _data[_loc8_];
         }
         else
         {
            _loc8_ = _minName[_index - 1];
            _loc9_ = int(_template[_loc8_]);
         }
         _loc8_ = _maxName[_index - 1];
         _loc7_ = int(_template[_loc8_]);
         _maxValue = _template[_loc8_];
         _progressTxt.text = _loc9_ + "/" + _loc7_;
         _loc5_ = _loc9_ / _loc7_ * 100;
         _redBar.gotoAndStop(_loc5_);
         if(_data)
         {
            _rateTxt.text = "x" + _data.addPer + "%";
         }
         else
         {
            _rateTxt.text = "";
         }
         if(_data)
         {
            _loc4_ = _dataValue - _oldDataValue;
            _loc6_ = _dataValue >= _maxValue;
            if(!_isFirst && param3 && _loc4_ > 0)
            {
               playMovie(_addArrowMc,_loc4_.toString(),_arrowTxt,_loc6_);
               _arrowTxt = _loc4_.toString();
               _delay = setTimeout(stopMovie,3000,_addArrowMc);
            }
            _isFirst = false;
            _oldDataValue = _dataValue;
         }
         _propertyName.text = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip" + _nameArr[_index - 1]);
      }
      
      private function playMovie(param1:MovieClip, param2:String, param3:String, param4:Boolean) : void
      {
         param1.gotoAndPlay(1);
         param1.visible = true;
         var _loc6_:MovieClip = param1["newMc"] as MovieClip;
         var _loc5_:MovieClip = param1["oldMc"] as MovieClip;
         _loc5_.visible = false;
         _loc5_["valueTxt"]["text"] = "";
         if(_loc6_["valueTxt"])
         {
            _loc5_["valueTxt"]["text"] = param3;
         }
         if(!_loc5_["valueTxt"]["text"])
         {
            _loc5_.visible = false;
         }
         if(param4)
         {
            _loc6_.gotoAndStop(2);
         }
         else
         {
            _loc6_.gotoAndStop(1);
            _loc6_["valueTxt"]["text"] = param2;
         }
      }
      
      private function stopMovie(param1:MovieClip) : void
      {
         clearTimeout(_delay);
         param1.gotoAndStop(1);
         param1.visible = false;
      }
      
      override public function dispose() : void
      {
         clearTimeout(_delay);
         ObjectUtils.disposeViolentMc(_redBar);
         _redBar = null;
         ObjectUtils.disposeObject(_propertyName);
         _propertyName = null;
         ObjectUtils.disposeObject(_progressTxt);
         _progressTxt = null;
         ObjectUtils.disposeObject(_rateTxt);
         _rateTxt = null;
         ObjectUtils.disposeViolentMc(_addArrowMc);
         _addArrowMc = null;
         _minName = null;
         _maxName = null;
         _dataName = null;
         _nameArr = null;
         _template = null;
         _data = null;
         super.dispose();
      }
   }
}

