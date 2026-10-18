package fashion
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.FashionManager;
   import mvc.module.fashion.FashionModel;
   import mvc.module.fashion.FashionPolishInfo;
   import yishi.datas.templates.FashionPolishTemplateInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   
   public class FashionRefreshAttributeView extends Sprite implements Disposeable
   {
      
      private var _nameTxt:FilterFrameText;
      
      private var _lvTxt:FilterFrameText;
      
      private var _arrtiItem1:FashionRefreshAttributeItem;
      
      private var _arrtiItem2:FashionRefreshAttributeItem;
      
      private var _arrtiItem3:FashionRefreshAttributeItem;
      
      private var _arrtiItem4:FashionRefreshAttributeItem;
      
      private var _needNameTxt:FilterFrameText;
      
      private var _needNumTxt:FilterFrameText;
      
      private var _type:int;
      
      private var _currentPos:int;
      
      public function FashionRefreshAttributeView(param1:int = 0)
      {
         _type = param1;
         super();
         initView();
      }
      
      private function initView() : void
      {
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("fashion.refreshAttriTxt");
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("fashion.refreshNoLvTxt");
         _arrtiItem1 = new FashionRefreshAttributeItem();
         _arrtiItem2 = new FashionRefreshAttributeItem();
         _arrtiItem3 = new FashionRefreshAttributeItem();
         _arrtiItem4 = new FashionRefreshAttributeItem();
         _needNameTxt = ComponentFactory.Instance.creatComponentByStylename("fashion.refreshAttriTxt");
         _needNumTxt = ComponentFactory.Instance.creatComponentByStylename("fashion.refreshNoLvTxt");
         addChild(_nameTxt);
         addChild(_lvTxt);
         addChild(_arrtiItem1);
         addChild(_arrtiItem2);
         addChild(_arrtiItem3);
         addChild(_arrtiItem4);
         addChild(_needNameTxt);
         addChild(_needNumTxt);
         _nameTxt.x = 20;
         _lvTxt.x = 85;
         _arrtiItem1.y = 16;
         _arrtiItem2.y = 27;
         _arrtiItem3.y = 40;
         _arrtiItem4.y = 64;
         _needNameTxt.y = 77;
         _needNumTxt.y = 88;
         _needNumTxt.x = 78;
         setTxtFrame();
         _nameTxt.text = LanguageMgr.GetTranslation("fashion.refreshView.tips05");
         _needNameTxt.text = LanguageMgr.GetTranslation("fashion.refreshView.tips06");
      }
      
      public function setRefeshLevel(param1:int) : void
      {
         _currentPos = param1;
         _arrtiItem1.addAttributeValue = "";
         _arrtiItem2.addAttributeValue = "";
         _arrtiItem3.addAttributeValue = "";
         _arrtiItem4.addAttributeValue = "";
         if(_type == 1)
         {
            currentInfo();
         }
         else if(_type == 2)
         {
            nextInfo();
         }
         else
         {
            maxInfo();
         }
      }
      
      private function currentInfo() : void
      {
         var _loc8_:FashionPolishTemplateInfo = null;
         var _loc6_:int = 0;
         var _loc7_:FashionPolishInfo = fashionModel.getPolishInfoBySontype(_currentPos);
         var _loc3_:int = Math.floor(_loc7_.level / 10);
         var _loc4_:int = 0;
         var _loc1_:int = int(FashionManager.instance.getSonTypeByindex(_currentPos));
         var _loc5_:int = int(fashionModel.getBookNum(_currentPos));
         var _loc2_:Array = FashionManager.instance.fashionModel.getIdentityedProperties();
         _loc6_ = _loc3_;
         while(_loc6_ >= 0)
         {
            _loc4_ = _loc6_ * 10;
            _loc4_ = int(_loc4_ == 0 ? 1 : _loc4_);
            _loc8_ = getTemplatesByLevelAndPos(_loc4_,_loc1_);
            if(_loc5_ >= _loc8_.NeedCount)
            {
               break;
            }
            _loc6_ -= 1;
         }
         _lvTxt.text = LanguageMgr.GetTranslation("fashion.refreshView.tips08",_loc4_);
         _needNumTxt.text = String(_loc8_.NeedCount);
         if(_loc4_ <= _loc7_.level)
         {
            _lvTxt.setFrame(2);
         }
         else
         {
            _lvTxt.setFrame(1);
         }
         if(_loc5_ >= _loc8_.NeedCount)
         {
            _needNumTxt.setFrame(2);
         }
         else
         {
            _needNumTxt.setFrame(1);
         }
         showLevelAdd(_loc4_,_loc1_);
      }
      
      private function nextInfo() : void
      {
         var _loc7_:FashionPolishTemplateInfo = null;
         var _loc5_:int = 0;
         var _loc6_:FashionPolishInfo = fashionModel.getPolishInfoBySontype(_currentPos);
         var _loc2_:int = Math.floor(_loc6_.level / 10) + 1;
         _loc2_ = int(_loc2_ > 10 ? 10 : _loc2_);
         var _loc3_:int = 0;
         var _loc1_:int = int(FashionManager.instance.getSonTypeByindex(_currentPos));
         var _loc4_:int = int(fashionModel.getBookNum(_currentPos));
         _loc5_ = _loc2_;
         while(_loc5_ > 0)
         {
            _loc3_ = _loc5_ * 10;
            _loc7_ = getTemplatesByLevelAndPos(_loc3_,_loc1_);
            if(_loc4_ >= _loc7_.NeedCount)
            {
               _loc3_ += 10;
               _loc3_ = int(_loc3_ >= _loc2_ * 10 ? _loc2_ * 10 : _loc3_);
               _loc7_ = getTemplatesByLevelAndPos(_loc3_,_loc1_);
               break;
            }
            _loc5_ -= 1;
         }
         _lvTxt.text = LanguageMgr.GetTranslation("fashion.refreshView.tips08",_loc3_);
         _needNumTxt.text = String(_loc7_.NeedCount);
         if(_loc3_ <= _loc6_.level)
         {
            _lvTxt.setFrame(2);
         }
         else
         {
            _lvTxt.setFrame(1);
         }
         if(_loc4_ >= _loc7_.NeedCount)
         {
            _needNumTxt.setFrame(2);
         }
         else
         {
            _needNumTxt.setFrame(1);
         }
         showLevelAdd(_loc3_,_loc1_);
      }
      
      private function maxInfo() : void
      {
         var _loc4_:FashionPolishInfo = fashionModel.getPolishInfoBySontype(_currentPos);
         var _loc2_:int = int(_loc4_.level);
         var _loc1_:int = int(FashionManager.instance.getSonTypeByindex(_currentPos));
         var _loc5_:FashionPolishTemplateInfo = getTemplatesByLevelAndPos(_loc2_,_loc1_);
         var _loc3_:int = int(fashionModel.getBookNum(_currentPos));
         _lvTxt.text = LanguageMgr.GetTranslation("fashion.refreshView.tips08",_loc2_);
         _needNumTxt.text = String(_loc5_.NeedCount);
         _lvTxt.setFrame(2);
         if(_loc3_ >= _loc5_.NeedCount)
         {
            _needNumTxt.setFrame(2);
         }
         else
         {
            _needNumTxt.setFrame(1);
         }
         showLevelAdd(_loc2_,_loc1_);
      }
      
      private function showLevelAdd(param1:int, param2:int) : void
      {
         var _loc3_:Array = FashionManager.instance.fashionModel.getIdentityedProperties();
         _arrtiItem1.attributeValue = LanguageMgr.GetTranslation("fashion.refreshView.tips01",_loc3_[0],"");
         _arrtiItem2.attributeValue = LanguageMgr.GetTranslation("fashion.refreshView.tips02",_loc3_[1],"");
         _arrtiItem3.attributeValue = LanguageMgr.GetTranslation("fashion.refreshView.tips03",_loc3_[2],"");
         _arrtiItem4.attributeValue = LanguageMgr.GetTranslation("fashion.refreshView.tips04",_loc3_[3],"");
         var _loc6_:FashionPolishTemplateInfo = getTemplatesByLevelAndPos(param1,param2);
         if(!_loc6_ || _loc6_.AppraisalAdd == 0)
         {
            return;
         }
         var _loc4_:int = 0;
         var _loc5_:String = "";
         switch(_currentPos)
         {
            case 0:
               _loc4_ = Math.floor(_loc6_.AppraisalAdd / 100 * _loc3_[3]);
               _loc5_ = LanguageMgr.GetTranslation("fashion.refreshView.tips09",_loc4_);
               _arrtiItem4.attributeValue = LanguageMgr.GetTranslation("fashion.refreshView.tips04",_loc3_[3],_loc5_);
               _arrtiItem4.addAttributeValue = LanguageMgr.GetTranslation("fashion.refreshView.tips11",_loc6_.AppraisalAdd);
               break;
            case 1:
               _loc4_ = Math.floor(_loc6_.AppraisalAdd / 100 * _loc3_[2]);
               _loc5_ = LanguageMgr.GetTranslation("fashion.refreshView.tips09",_loc4_);
               _arrtiItem3.attributeValue = LanguageMgr.GetTranslation("fashion.refreshView.tips03",_loc3_[2],_loc5_);
               _arrtiItem3.addAttributeValue = LanguageMgr.GetTranslation("fashion.refreshView.tips11",_loc6_.AppraisalAdd);
               break;
            case 2:
               _loc4_ = Math.floor(_loc6_.AppraisalAdd / 100 * _loc3_[1]);
               _loc5_ = LanguageMgr.GetTranslation("fashion.refreshView.tips09",_loc4_);
               _arrtiItem2.attributeValue = LanguageMgr.GetTranslation("fashion.refreshView.tips02",_loc3_[1],_loc5_);
               _arrtiItem2.addAttributeValue = LanguageMgr.GetTranslation("fashion.refreshView.tips11",_loc6_.AppraisalAdd);
               break;
            case 3:
               _loc4_ = Math.floor(_loc6_.AppraisalAdd / 100 * _loc3_[0]);
               _loc5_ = LanguageMgr.GetTranslation("fashion.refreshView.tips09",_loc4_);
               _arrtiItem1.attributeValue = LanguageMgr.GetTranslation("fashion.refreshView.tips01",_loc3_[0],_loc5_);
               _arrtiItem1.addAttributeValue = LanguageMgr.GetTranslation("fashion.refreshView.tips11",_loc6_.AppraisalAdd);
         }
         if(_type == 3)
         {
            _arrtiItem1.addAttributeValue = "";
            _arrtiItem2.addAttributeValue = "";
            _arrtiItem3.addAttributeValue = "";
            _arrtiItem4.addAttributeValue = "";
         }
      }
      
      private function setTxtFrame() : void
      {
         _nameTxt.setFrame(_type);
         _needNameTxt.setFrame(_type);
         _arrtiItem1.gotoFrame(_type);
         _arrtiItem2.gotoFrame(_type);
         _arrtiItem3.gotoFrame(_type);
         _arrtiItem4.gotoFrame(_type);
      }
      
      private function getTemplatesByLevelAndPos(param1:int, param2:int) : FashionPolishTemplateInfo
      {
         return TempleteManager.instance.fashionPolishTemplateCate.getTemplatesByLevelAndPos(param1,param2);
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_lvTxt);
         _lvTxt = null;
         ObjectUtils.disposeObject(_arrtiItem1);
         _arrtiItem1 = null;
         ObjectUtils.disposeObject(_arrtiItem2);
         _arrtiItem2 = null;
         ObjectUtils.disposeObject(_arrtiItem3);
         _arrtiItem3 = null;
         ObjectUtils.disposeObject(_arrtiItem4);
         _arrtiItem4 = null;
         ObjectUtils.disposeObject(_needNameTxt);
         _needNameTxt = null;
         ObjectUtils.disposeObject(_needNumTxt);
         _needNumTxt = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

