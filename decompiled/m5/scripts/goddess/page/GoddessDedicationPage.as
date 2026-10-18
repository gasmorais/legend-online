package goddess.page
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import goddess.item.GoddessDedicationSkillItem;
   import manager.LanguageMgr;
   import managers.GodDessManager;
   import mvc.module.goddess.GodDessModel;
   import mvc.module.goddess.GoddessInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.view.base.ProgressPanel;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class GoddessDedicationPage extends GoddessBaseView
   {
      
      private var _bg:MutipleImage;
      
      private var _progress:ProgressPanel;
      
      private var _dedicationBtn:IconButton;
      
      private var _item:BaseIconView;
      
      private var _needItemNumTxt:FilterFrameText;
      
      private var _itemTitle:FilterFrameText;
      
      private var _lvSp:Sprite;
      
      private var _lvData:BitmapData;
      
      private var _skList:Vector.<GoddessDedicationSkillItem>;
      
      private var _posList:Array = [[557,194],[400,262],[399,100],[725,100],[724,262]];
      
      private const MAX:int = 5;
      
      public function GoddessDedicationPage()
      {
         super();
         initView();
         initEvent();
         data = model.selectInfo;
      }
      
      private function get model() : GodDessModel
      {
         return GodDessManager.instance.model;
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         _dedicationBtn.addEventListener("click",clickHandler);
         MsgMan.addObserver("GodDessEvent.devote",this,devoteHandler);
         MsgMan.addObserver("GodDessEvent.expDevote",this,expDevoteHandler);
         MsgMan.addObserver("GodDessEvent.choose",this,chooseHandler);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         _dedicationBtn.removeEventListener("click",clickHandler);
         MsgMan.removeObserver("GodDessEvent.devote",this,devoteHandler);
         MsgMan.removeObserver("GodDessEvent.expDevote",this,expDevoteHandler);
         MsgMan.removeObserver("GodDessEvent.choose",this,chooseHandler);
      }
      
      private function chooseHandler(param1:String, param2:Object) : void
      {
         var _loc3_:GoddessInfo = param2 as GoddessInfo;
         data = _loc3_;
      }
      
      private function devoteHandler(param1:String, param2:Object) : void
      {
         var _loc3_:GoddessInfo = param2 as GoddessInfo;
         if(_data == _loc3_)
         {
            data = _loc3_;
         }
      }
      
      private function expDevoteHandler(param1:String, param2:Object) : void
      {
         var _loc3_:GoddessInfo = param2 as GoddessInfo;
         if(_data == _loc3_)
         {
            refreshExp(true);
         }
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         if(_data == null)
         {
            return;
         }
         var _loc2_:int = int(_inputTxt.text);
         if(_loc2_ <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("goddess.input.zeroTip"));
            return;
         }
         _lastHasGoodsNum = _hasGoodsNum;
         GodDessManager.instance.requestOp(4,_data.tempInfo.TemplateId,_loc2_);
      }
      
      private function initView() : void
      {
         var _loc1_:GoddessDedicationSkillItem = null;
         var _loc2_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.dedicationBg");
         _progress = ComponentFactory.Instance.creatCustomObject("ui.goddess.dedicationProgressPanel");
         _dedicationBtn = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.dedicationBtn");
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.dedicatioInputTxt");
         _item = ComponentFactory.Instance.creatCustomObject("ui.goddess.dedicationItemIcon");
         _needItemNumTxt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.dedicationHasTipTxt");
         _itemTitle = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.dedicatioInputTitleTxt");
         _lvData = ComponentFactory.Instance.creatBitmap("asset.goddess.lvNumData").bitmapData;
         _lvSp = ComponentFactory.Instance.creatCustomObject("ui.goddess.devoteGradeSp");
         _progress.initView("asset.goddess.dedication.barBack","asset.goddess.dedication.bar","ui.goddess.dedicationProgressTxt");
         addChild(_bg);
         addChild(_progress);
         addChild(_dedicationBtn);
         addChild(_inputTxt);
         addChild(_item);
         addChild(_needItemNumTxt);
         addChild(_itemTitle);
         addChild(_lvSp);
         _itemTitle.text = LanguageMgr.GetTranslation("goddess.dedication.numTitle");
         _skList = new Vector.<GoddessDedicationSkillItem>();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new GoddessDedicationSkillItem(_loc2_ + 1);
            _skList[_loc2_] = _loc1_;
            addChild(_loc1_);
            _loc1_.x = _posList[_loc2_][0];
            _loc1_.y = _posList[_loc2_][1];
            _loc2_++;
         }
      }
      
      private function refreshExp(param1:Boolean = false) : void
      {
         if(_data.nextDedicationTempInfo)
         {
            _progress.progressValue(_data.devoteGp,_data.nextDedicationTempInfo.NeedGp);
            needItemId = _data.nextDedicationTempInfo.NeedItemId;
            _item.icon = IconFactory.getGoodsIconByTID(_needItemId);
            _item.tipData = _gInfo;
            if(_needItemTempInfo)
            {
               _needItemNumTxt.text = LanguageMgr.GetTranslation("goddess.level.hasItem",_needItemTempInfo.TemplateName,_hasGoodsNum);
               _inputTxt.text = Math.min(_hasGoodsNum,1) + "";
            }
            _dedicationBtn.enable = true;
         }
         else
         {
            _dedicationBtn.enable = false;
            _progress.showMax();
            needItemId = _data.dedicationTempInfo.NeedItemId;
            _item.icon = IconFactory.getGoodsIconByTID(_needItemId);
            _item.tipData = _gInfo;
            if(_needItemTempInfo)
            {
               _needItemNumTxt.text = LanguageMgr.GetTranslation("goddess.level.hasItem",_needItemTempInfo.TemplateName,_hasGoodsNum);
               _inputTxt.text = Math.min(_hasGoodsNum,1) + "";
            }
         }
         if(param1)
         {
            showAddExp();
         }
      }
      
      private function refreshLv() : void
      {
         ObjectUtils.disposeAllChildren(_lvSp);
         NumberViewUtils.refreshValue(_data.devote,_lvSp,_lvData,15,19,10,15);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:GoddessDedicationSkillItem in _skList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _skList = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_dedicationBtn);
         _dedicationBtn = null;
         ObjectUtils.disposeObject(_lvData);
         _lvData = null;
         ObjectUtils.disposeAllChildren(_lvSp);
         _lvSp = null;
         ObjectUtils.disposeObject(_itemTitle);
         _itemTitle = null;
         ObjectUtils.disposeObject(_needItemNumTxt);
         _needItemNumTxt = null;
         ObjectUtils.disposeObject(_item);
         _item = null;
         ObjectUtils.disposeObject(_inputTxt);
         _inputTxt = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
      
      override public function set data(param1:GoddessInfo) : void
      {
         if(_isDispose)
         {
            return;
         }
         super.data = param1;
         refreshLv();
         refreshSkills();
         refreshExp();
      }
      
      private function refreshSkills() : void
      {
         var _loc3_:SkillTempInfo = null;
         var _loc4_:Array = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_data)
         {
            _loc3_ = TempleteManager.instance.getSkillTemplateInfoById(_data.dedicationTempInfo.SkillId);
            if(_loc3_)
            {
               _skList[0].refreshView(_loc3_);
               _loc4_ = _loc3_.BufferIds.split(",");
               _loc1_ = int(_loc4_.length);
               if(_loc1_ > 5)
               {
                  _loc1_ = 5;
               }
               _loc2_ = 0;
               _loc2_ = 1;
               while(_loc2_ < 5)
               {
                  _skList[_loc2_].refreshViewByBuff(null);
                  _loc2_++;
               }
               _loc2_ = 1;
               while(_loc2_ < _loc1_)
               {
                  _skList[_loc2_].refreshViewByBuff(_loc4_[_loc2_]);
                  _loc2_++;
               }
            }
         }
      }
   }
}

