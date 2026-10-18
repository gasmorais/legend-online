package armyII.viewII.stone.view
{
   import bag.events.BagEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ArmySocketOutManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.RuneGemTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.base.ProgressPanel;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   
   public class StoneIntensifyView extends Sprite
   {
      
      private var _progress:ProgressPanel;
      
      private var _icon:BaseItemView;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _metrail:BaseIconView;
      
      private var _btn:IconButton;
      
      private var _hastxt:FilterFrameText;
      
      private var _needtxt:FilterFrameText;
      
      private var _inputTxt:FilterFrameText;
      
      private var _hasbg:Image;
      
      private var _row:Image;
      
      private var _data:GoodsInfo;
      
      private var _currRuneGemTempInfo:RuneGemTempInfo;
      
      private var _nextRuneGemTempInfo:RuneGemTempInfo;
      
      private var _upgradeAlllist:Array = [];
      
      private const propertyList:Array = ["Power","Agility","Intellect","Physique","Captain"];
      
      private var _currPropertyTxt:FilterFrameText;
      
      private var _nextPropertyTxt:FilterFrameText;
      
      private var _effect:MovieClip;
      
      private var _line:Bitmap;
      
      private var _hasNum:int;
      
      private const GD_ID:int = 10000000;
      
      private var _lastGrade:int = -1;
      
      public function StoneIntensifyView()
      {
         super();
         initView();
         initEvent();
         _inputTxt.text = "1";
      }
      
      private function initView() : void
      {
         _upgradeAlllist = TempleteManager.instance.getTemplatesByType(160);
         _icon = ComponentFactory.Instance.creatCustomObject("ui.army.fwIcon2.BaseItemView");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.army.fwnameTxt2");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.army.stone.Nametxt");
         _metrail = ComponentFactory.Instance.creatCustomObject("ui.army.stone.NeeditemIcon");
         _btn = ComponentFactory.Instance.creatComponentByStylename("armyII.stone.qhBtn");
         _hastxt = ComponentFactory.Instance.creatComponentByStylename("ui.army.stone.HasTipTxt");
         _needtxt = ComponentFactory.Instance.creatComponentByStylename("ui.army.stone.NeedTipTxt");
         _hasbg = ComponentFactory.Instance.creatComponentByStylename("ui.army.stone.qhnumBg");
         _row = ComponentFactory.Instance.creatComponentByStylename("ui.army.stone.qhRow");
         _progress = ComponentFactory.Instance.creatCustomObject("ui.army.stone.lvProgressPanel");
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("ui.army.stone.InputTxt");
         _needtxt.text = LanguageMgr.GetTranslation("goddess.advance.inputItemNum");
         _currPropertyTxt = ComponentFactory.Instance.creatComponentByStylename("ui.army.stoneProTxt");
         _nextPropertyTxt = ComponentFactory.Instance.creatComponentByStylename("ui.army.stoneProTxt2");
         _effect = ComponentFactory.Instance.creatCustomObject("asset.army.stoneUpEffect");
         _line = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         addChild(_line);
         addChild(_icon);
         addChild(_gradeTxt);
         addChild(_nameTxt);
         addChild(_metrail);
         addChild(_btn);
         addChild(_hastxt);
         addChild(_needtxt);
         addChild(_hasbg);
         addChild(_inputTxt);
         addChild(_row);
         addChild(_progress);
         addChild(_currPropertyTxt);
         addChild(_nextPropertyTxt);
         addChild(_effect);
         _btn.enable = false;
         _effect.gotoAndStop(_effect.totalFrames);
         _currPropertyTxt.setFrame(1);
         _nextPropertyTxt.setFrame(2);
         _progress.initView("asset.army.proBg","asset.army.proBar","army.stone.progressTxt");
         _line.x = 81;
         _line.y = 95;
      }
      
      private function initEvent() : void
      {
         _btn.addEventListener("click",clickHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",updateBagHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",deleteBagHandler);
         if(_inputTxt)
         {
            _inputTxt.addEventListener("change",__inputChangeHandler);
         }
      }
      
      private function removeEvent() : void
      {
         _btn.removeEventListener("click",clickHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",updateBagHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",deleteBagHandler);
         if(_inputTxt)
         {
            _inputTxt.removeEventListener("change",__inputChangeHandler);
         }
      }
      
      private function __inputChangeHandler(param1:Event = null) : void
      {
         var _loc2_:int = int(_inputTxt.text);
         _inputTxt.text = "" + _loc2_;
         if(_loc2_ >= _hasNum)
         {
            _inputTxt.text = "" + _hasNum;
            _loc2_ = _hasNum;
         }
         if(_loc2_ <= 0)
         {
            _inputTxt.text = "0";
            _btn.enable = false;
         }
         else
         {
            _btn.enable = true;
         }
      }
      
      private function updateBagHandler(param1:BagEvent) : void
      {
         var _loc2_:GoodsInfo = param1.info;
         if(_loc2_.id == _data.id)
         {
            data = _loc2_;
            _effect.gotoAndPlay(1);
         }
      }
      
      private function deleteBagHandler(param1:BagEvent = null) : void
      {
         _hasNum = GoodsManager.instance.getGoodsNumByTempId(10000000);
         _hastxt.text = LanguageMgr.GetTranslation("army.stone.has",_hasNum);
         __inputChangeHandler();
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = int(_inputTxt.text);
         ArmySocketOutManager.sendUpStoneRune(-1,_data.pos,-1,_loc2_,_data.bagType);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_gradeTxt);
         _gradeTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_metrail);
         _metrail = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_hastxt);
         _hastxt = null;
         ObjectUtils.disposeObject(_needtxt);
         _needtxt = null;
         ObjectUtils.disposeObject(_hasbg);
         _hasbg = null;
         ObjectUtils.disposeObject(_row);
         _row = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_inputTxt);
         _inputTxt = null;
         ObjectUtils.disposeObject(_currPropertyTxt);
         _currPropertyTxt = null;
         ObjectUtils.disposeObject(_nextPropertyTxt);
         _nextPropertyTxt = null;
         ObjectUtils.disposeViolentMc(_effect);
         _effect = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
         _currRuneGemTempInfo = null;
         _nextRuneGemTempInfo = null;
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         var _loc3_:GoodsTemplateInfo = null;
         var _loc8_:GoodsInfo = null;
         var _loc2_:Array = null;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc10_:UpgradeTemplateInfo = null;
         _data = param1;
         if(_data != null)
         {
            _loc3_ = _data.templateInfo;
            _icon.data = _data;
            _loc8_ = new GoodsInfo();
            _loc8_.templateId = _loc3_.Refresh;
            _metrail.icon = IconFactory.getGoodsIconByTID(_loc3_.Refresh);
            _metrail.tipData = _loc8_;
            _loc2_ = getListByType(_loc3_.SonType);
            deleteBagHandler();
            _loc4_ = int(_loc2_[_loc2_.length - 1] ? _loc2_[_loc2_.length - 1].Grades : 0);
            _gradeTxt.text = LanguageMgr.GetTranslation("army.stone.lvmax",_loc4_);
            if(_lastGrade != _data.strengthenGrade)
            {
               _loc7_ = int(_data.strengthenGrade == 0 ? 1 : _data.strengthenGrade);
               _currRuneGemTempInfo = TempleteManager.instance.runeGemInfoCate.getInfo(_loc3_.SonType,_loc3_.Property1,_loc7_);
               _nextRuneGemTempInfo = TempleteManager.instance.runeGemInfoCate.getInfo(_currRuneGemTempInfo.Types,_currRuneGemTempInfo.RuneGemTypes,_loc7_ + 1);
               _nameTxt.setFrame(_loc3_.Profile);
               _nameTxt.text = _loc3_.TemplateName + "  " + LanguageMgr.GetTranslation("public.level2",_data.strengthenGrade);
               if(_data.strengthenGrade == 0)
               {
                  _loc9_ = getPropertys(_data.templateInfo);
                  _currPropertyTxt.text = _loc9_[0];
               }
               else
               {
                  _loc9_ = getPropertys(_currRuneGemTempInfo);
                  _currPropertyTxt.text = _loc9_[0];
               }
               if(_nextRuneGemTempInfo)
               {
                  _loc5_ = getPropertys(_nextRuneGemTempInfo);
                  _loc6_ = _loc5_[1] - _loc9_[1];
                  _nextPropertyTxt.text = _loc5_[0] + LanguageMgr.GetTranslation("army.stone.nextAdd",_loc6_);
                  _nextPropertyTxt.setFrame(2);
               }
               else
               {
                  _nextPropertyTxt.text = LanguageMgr.GetTranslation("army.stone.fullLV");
                  _nextPropertyTxt.setFrame(3);
               }
            }
            _loc10_ = getOneFrom(_loc2_,_currRuneGemTempInfo.Types,_currRuneGemTempInfo.Grades + 1);
            if(_loc10_)
            {
               _progress.progressValue(_data.strBlessValue,_loc10_.Data);
            }
            else
            {
               _btn.enable = false;
               _progress.showMax();
            }
         }
      }
      
      private function getListByType(param1:int) : Array
      {
         var _loc5_:UpgradeTemplateInfo = null;
         var _loc4_:int = 0;
         var _loc3_:int = int(_upgradeAlllist.length);
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _upgradeAlllist[_loc4_];
            if(_loc5_.TemplateId == param1)
            {
               _loc2_.push(_loc5_);
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function getOneFrom(param1:Array, param2:int, param3:int) : UpgradeTemplateInfo
      {
         for each(var _loc4_:UpgradeTemplateInfo in param1)
         {
            if(_loc4_.Grades == param3 && _loc4_.TemplateId == param2)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      private function getPropertys(param1:Object) : Array
      {
         var _loc2_:String = null;
         var _loc6_:int = 0;
         var _loc5_:int = int(this.propertyList.length);
         var _loc3_:String = "";
         var _loc4_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = this.propertyList[_loc6_];
            if(param1[_loc2_] > 0)
            {
               _loc4_ = int(param1[_loc2_]);
               _loc3_ = LanguageMgr.GetTranslation("army.stone." + _loc2_,_loc4_);
               break;
            }
            _loc6_++;
         }
         return [_loc3_,_loc4_];
      }
   }
}

