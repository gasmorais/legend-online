package battle.view.buffer
{
   import battle.data.BufferDamageData;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.templates.BufferTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.BaseTip;
   
   public class BufferListItemTip extends BaseTip
   {
      
      private var _icon:BaseIconView;
      
      private var _describe:FilterFrameText;
      
      private var _turnText:FilterFrameText;
      
      private var _countText:FilterFrameText;
      
      private var _dispelText:FilterFrameText;
      
      private var _splitLine:Bitmap;
      
      private var _layerBox:HBox;
      
      private var _maxLayerText:FilterFrameText;
      
      private var _maxValueText:FilterFrameText;
      
      private var _turnHBox:HBox;
      
      private var _turnNumCon:Sprite;
      
      private var _turnNum:Bitmap;
      
      private var _countBox:HBox;
      
      private var _countNumCon:Sprite;
      
      private var _countNum:Bitmap;
      
      private var _con:VBox;
      
      public function BufferListItemTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 330;
         _icon = ComponentFactory.Instance.creatCustomObject("tips.BufferItemTip.Icon");
         _describe = ComponentFactory.Instance.creatComponentByStylename("tips.BufferItemTipNameText");
         _turnText = ComponentFactory.Instance.creatComponentByStylename("tips.BufferItemTipTurnText");
         _countText = ComponentFactory.Instance.creatComponentByStylename("tips.BufferItemTipCountText");
         _dispelText = ComponentFactory.Instance.creatComponentByStylename("tips.BufferItemTip.dispelText");
         _splitLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _maxLayerText = ComponentFactory.Instance.creatComponentByStylename("tips.BufferItemTip.maxLayerText");
         _maxValueText = ComponentFactory.Instance.creatComponentByStylename("tips.BufferItemTip.maxValueText");
         _layerBox = ComponentFactory.Instance.creatComponentByStylename("tips.bufferlistitemtip.layerBox");
         _turnHBox = ComponentFactory.Instance.creatComponentByStylename("tips.bufferlistitemtip.turnBox");
         _countBox = ComponentFactory.Instance.creatComponentByStylename("tips.bufferlistitemtip.countBox");
         _turnNum = ComponentFactory.Instance.creatBitmap("asset.tips.equipnum");
         _countNum = ComponentFactory.Instance.creatBitmap("asset.tips.equipnum");
         _turnNumCon = new Sprite();
         _countNumCon = new Sprite();
         _con = ComponentFactory.Instance.creatComponentByStylename("tips.bufferlistitemtip.countVBox");
         addChild(_icon);
         addChild(_con);
         _splitLine.width = 200;
      }
      
      override protected function updateTransform() : void
      {
         var _loc4_:String = null;
         var _loc3_:BufferTemplateInfo = null;
         if(!tipData)
         {
            return;
         }
         clean();
         _icon.visible = true;
         _splitLine.visible = true;
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(tipData is BufferDamageData)
         {
            _loc2_ = (tipData as BufferDamageData).currentTurn;
            _loc1_ = (tipData as BufferDamageData).countWay;
            _loc3_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID((tipData as BufferDamageData).templateId);
            _loc4_ = getBufferNameByDamageData(tipData as BufferDamageData);
         }
         else if(tipData is BufferTemplateInfo)
         {
            _loc3_ = tipData as BufferTemplateInfo;
            if(_loc3_)
            {
               _loc4_ = _loc3_.BufferName;
            }
         }
         if(!_loc3_)
         {
            return;
         }
         _icon.icon = IconFactory.getCommonIconPath(_loc3_.Icon);
         _describe.htmlText = _loc4_;
         _describe.height = _describe.textHeight + 5;
         _con.addChild(_describe);
         if(_loc2_ > 0)
         {
            NumberViewUtils.getNumberView(_loc2_,_turnNumCon,_turnNum.bitmapData,15,21,15,15,"0123456789",1);
            _turnHBox.addChild(_turnNumCon);
            _turnText.text = LanguageMgr.GetTranslation("battle.view.buffer.BufferListItemTip.turnText03");
            _turnText.width = 60;
            _turnHBox.addChild(_turnText);
            _turnHBox.x = 200 - _turnHBox.width - 8;
            _con.addChild(_turnHBox);
         }
         if(_loc1_ > 0)
         {
            NumberViewUtils.getNumberView(_loc1_,_countNumCon,_countNum.bitmapData,15,21,15,15,"0123456789",1);
            _countBox.addChild(_countNumCon);
            _countText.text = LanguageMgr.GetTranslation("battle.view.buffer.BufferListItemTip.turnText02");
            _countText.width = 60;
            _countBox.addChild(_countText);
            _countBox.x = 200 - _countBox.width - 8;
            _con.addChild(_countBox);
         }
         if(_loc3_.Dispel != 0)
         {
            _dispelText.text = LanguageMgr.GetTranslation("battle.view.buffer.BufferListItemTip.noDispel");
            _con.addChild(_dispelText);
         }
         if(_loc3_.PressCount > 0)
         {
            _maxLayerText.text = LanguageMgr.GetTranslation("battle.view.buffer.BufferListItemTip.maxLayerText");
            _maxValueText.text = LanguageMgr.GetTranslation("battle.view.buffer.BufferListItemTip.maxValueText",_loc3_.PressCount);
            _layerBox.addChild(_maxLayerText);
            _layerBox.addChild(_maxValueText);
            _con.addChild(_splitLine);
            _con.addChild(_layerBox);
         }
         _bg.height = _con.y + _con.height + 15;
         _bg.width = Math.max(_con.x + _con.width + 15,_con.x + _describe.x + _describe.textWidth + 15);
      }
      
      private function clean() : void
      {
         _describe.text = "";
         _turnText.text = "";
         _countText.text = "";
         _dispelText.text = "";
         _maxLayerText.text = "";
         _maxValueText.text = "";
         _icon.visible = false;
         _splitLine.visible = false;
         _turnHBox.removeAllChild();
         _countBox.removeAllChild();
         _layerBox.removeAllChild();
         _con.removeAllChild();
      }
      
      private function getBufferNameByDamageData(param1:BufferDamageData) : String
      {
         var _loc3_:String = null;
         var _loc2_:int = 0;
         var _loc4_:BufferTemplateInfo = TempleteManager.instance.bufferTemplateCate.getTemplateByID(param1.templateId);
         if(_loc4_)
         {
            _loc3_ = StringHelper.getSubStrBetweenTwoChar("{","}",_loc4_.BufferName);
            if(StringHelper.isNullOrEmpty(_loc3_))
            {
               return _loc4_.BufferName;
            }
            _loc2_ = _loc4_.hasOwnProperty(_loc3_) ? Math.abs(_loc4_[_loc3_]) * param1.layerCount : 0;
            return StringHelper.replaceStr(_loc4_.BufferName,"{" + _loc3_ + "}",String(_loc2_));
         }
         return "";
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_splitLine);
         _splitLine = null;
         ObjectUtils.disposeObject(_maxLayerText);
         _maxLayerText = null;
         ObjectUtils.disposeObject(_maxValueText);
         _maxValueText = null;
         ObjectUtils.disposeObject(_layerBox);
         _layerBox = null;
         if(_countNum)
         {
            ObjectUtils.disposeObject(_countNum);
         }
         _countNum = null;
         ObjectUtils.disposeObject(_turnHBox);
         _turnHBox = null;
         ObjectUtils.disposeObject(_countBox);
         _countBox = null;
         ObjectUtils.disposeObject(_turnText);
         _turnText = null;
         ObjectUtils.disposeObject(_countText);
         _countText = null;
         ObjectUtils.disposeObject(_describe);
         _describe = null;
         ObjectUtils.disposeObject(_turnNumCon);
         _turnNumCon = null;
         ObjectUtils.disposeObject(_turnNum);
         _turnNumCon = null;
         ObjectUtils.disposeObject(_countNumCon);
         _countNumCon = null;
         ObjectUtils.disposeObject(_con);
         _con = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

