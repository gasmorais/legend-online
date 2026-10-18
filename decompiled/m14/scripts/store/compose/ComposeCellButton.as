package store.compose
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.Event;
   import manager.LanguageMgr;
   import mvc.module.store.ComposeGoodsInfo;
   import mvc.module.store.StoreModel;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.WarSoulTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   
   public class ComposeCellButton extends SelectedTextButton implements IListCell
   {
      
      public static const P_iconStyle:String = "iconStyle";
      
      public static const P_numberStyle:String = "numberStyle";
      
      public static const SUIT_CELL:int = 1;
      
      public static const PROP_CELL:int = 2;
      
      public static const JEWEL_CELL:int = 3;
      
      public static const SUIT_SUBCELL:int = 4;
      
      public static const AVENGER_PROP:int = 5;
      
      public static const THESEUS_PROP:int = 6;
      
      private var _data:ComposeGoodsInfo;
      
      private var _iconStyle:String;
      
      private var _numberStyle:String;
      
      private var _list:List;
      
      private var _icon:ScaleFrameImage;
      
      private var _numberTxt:FilterFrameText;
      
      public function ComposeCellButton()
      {
         super();
      }
      
      public function set iconStyle(param1:String) : void
      {
         if(_iconStyle == param1)
         {
            return;
         }
         _iconStyle = param1;
         onPropertiesChanged("iconStyle");
      }
      
      public function set numberStyle(param1:String) : void
      {
         if(_numberStyle == param1)
         {
            return;
         }
         _numberStyle = param1;
         onPropertiesChanged("numberStyle");
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_numberTxt)
         {
            addChild(_numberTxt);
         }
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["iconStyle"])
         {
            _icon = ComponentFactory.Instance.creatComponentByStylename(_iconStyle);
         }
         if(_changedPropeties["numberStyle"])
         {
            _numberTxt = ComponentFactory.Instance.creatComponentByStylename(_numberStyle);
         }
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      private function __changeHandler(param1:Event) : void
      {
         if(_data)
         {
            updateView();
         }
         if(selected)
         {
            selected = true;
         }
      }
      
      public function setCellValue(param1:*) : void
      {
         if(_data)
         {
            _data.removeEventListener("change",__changeHandler);
            model.removeEventListener("COMPOSE_COMPLETE",__changeHandler);
         }
         _data = param1 as ComposeGoodsInfo;
         if(_data)
         {
            _data.addEventListener("change",__changeHandler);
            model.addEventListener("COMPOSE_COMPLETE",__changeHandler);
            updateView();
         }
         else
         {
            if(_textField)
            {
               _textField["text"] = "";
            }
            if(_numberTxt)
            {
               _numberTxt.text = "";
            }
         }
      }
      
      private function updateView() : void
      {
         var _loc2_:WarSoulTempInfo = null;
         var _loc1_:GoodsTemplateInfo = null;
         switch(int(_data.cellType) - 1)
         {
            case 0:
            case 2:
            case 4:
            case 5:
               iconVisible = true;
               _textField["text"] = getSuitName(_data.cellType,_data.groupId);
               selectedView = selected;
               setNumTxt();
               return;
            default:
               iconVisible = false;
               if(!_data.template)
               {
                  return;
               }
               var _loc3_:Array = [361,362,363,364,365,366,367,368,369];
               if(_loc3_.indexOf(_data.template.Types) != -1)
               {
                  _loc2_ = TempleteManager.instance.warsoulCate.getTempInfoById(_data.template.NewMaterial);
                  if(_loc2_)
                  {
                     selectedView = selected;
                     if(_textField)
                     {
                        _textField["text"] = _loc2_.Name;
                     }
                     setNumTxt();
                  }
                  else
                  {
                     if(_textField)
                     {
                        _textField["text"] = LanguageMgr.GetTranslation("store.view.compose.ComposeCellButton.cannotFindGoods") + _data.template.NewMaterial;
                        setNameFrame(1);
                     }
                     if(_numberTxt)
                     {
                        _numberTxt.text = "";
                        setNumFrame(1);
                     }
                  }
               }
               else
               {
                  _loc1_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.template.NewMaterial);
                  if(_loc1_)
                  {
                     selectedView = selected;
                     if(_textField)
                     {
                        _textField["text"] = _loc1_.TemplateName;
                     }
                     setNumTxt();
                  }
                  else
                  {
                     if(_textField)
                     {
                        _textField["text"] = LanguageMgr.GetTranslation("store.view.compose.ComposeCellButton.cannotFindGoods") + _data.template.NewMaterial;
                        setNameFrame(1);
                     }
                     if(_numberTxt)
                     {
                        _numberTxt.text = "";
                        setNumFrame(1);
                     }
                  }
               }
               return;
         }
      }
      
      private function set selectedView(param1:Boolean) : void
      {
         if(_selectedButton)
         {
            _selectedButton.visible = selected;
         }
         if(_unSelectedButton)
         {
            _unSelectedButton.visible = !selected;
         }
         if(selected)
         {
            if(_textField)
            {
               setNameFrame(2);
            }
            if(_numberTxt)
            {
               setNumFrame(2);
            }
         }
         else if(canMakeCount)
         {
            if(_textField)
            {
               setNameFrame(3);
            }
            if(_numberTxt)
            {
               setNumFrame(3);
            }
         }
         else
         {
            if(_textField)
            {
               setNameFrame(1);
            }
            if(_numberTxt)
            {
               setNumFrame(1);
            }
         }
         setIconFrame();
      }
      
      private function setNameFrame(param1:int) : void
      {
         if(!_data)
         {
            return;
         }
         switch(int(_data.cellType) - 1)
         {
            case 0:
            case 2:
            case 4:
            case 5:
               if(param1 == 1)
               {
                  (_textField as FilterFrameText).setFrame(7);
               }
               if(param1 != 1)
               {
                  (_textField as FilterFrameText).setFrame(param1);
               }
               _textField.x = 18;
               break;
            case 3:
               _textField.x = 25;
               if(param1 == 1)
               {
                  (_textField as FilterFrameText).setFrame(4);
               }
               if(param1 == 2)
               {
                  (_textField as FilterFrameText).setFrame(5);
               }
               if(param1 == 3)
               {
                  (_textField as FilterFrameText).setFrame(6);
               }
               break;
            default:
               _textField.x = 5;
               (_textField as FilterFrameText).setFrame(param1);
         }
      }
      
      private function setNumFrame(param1:int) : void
      {
         if(!_data)
         {
            return;
         }
         switch(int(_data.cellType) - 4)
         {
            case 0:
               if(param1 == 1)
               {
                  _numberTxt.setFrame(4);
               }
               if(param1 == 2)
               {
                  _numberTxt.setFrame(5);
               }
               if(param1 == 3)
               {
                  _numberTxt.setFrame(6);
               }
               break;
            default:
               _numberTxt.setFrame(param1);
         }
      }
      
      private function setIconFrame() : void
      {
         if(_icon)
         {
            selected ? _icon.setFrame(2) : _icon.setFrame(1);
         }
      }
      
      private function set iconVisible(param1:Boolean) : void
      {
         if(_icon)
         {
            if(param1)
            {
               setIconFrame();
               addChild(_icon);
            }
            else if(_icon.parent)
            {
               _icon.parent.removeChild(_icon);
            }
         }
      }
      
      private function setNumTxt() : void
      {
         if(_numberTxt)
         {
            _numberTxt.text = canMakeCount;
            if(!canMakeCount && Boolean(model.isCanMake))
            {
               if(!_list)
               {
                  return;
               }
               (_list.model as VectorListModel).remove(getCellValue());
               _list.updateListView();
               _list = null;
            }
         }
      }
      
      private function getSuitName(param1:int, param2:int) : String
      {
         var _loc3_:String = null;
         switch(param1 - 1)
         {
            case 0:
               if(param2 == 85)
               {
                  _loc3_ = LanguageMgr.GetTranslation("store.view.compose.ComposeCellButton.changeJob");
               }
               else if(param2 == 90)
               {
                  _loc3_ = LanguageMgr.GetTranslation("store.view.compose.ComposeCellButton.heraldryandrelic");
               }
               else if(param2 == 100)
               {
                  _loc3_ = LanguageMgr.GetTranslation("pet.PetFrame.equipBag");
               }
               else if(param2 == 105)
               {
                  _loc3_ = LanguageMgr.GetTranslation("store.view.compose.ComposeCellButton.shenqika");
               }
               else if(param2 == 110)
               {
                  _loc3_ = LanguageMgr.GetTranslation("store.view.compose.ComposeCellButton.monster");
               }
               else if(param2 == 115)
               {
                  _loc3_ = LanguageMgr.GetTranslation("store.view.compose.ComposeCellButton.goddessEquip");
               }
               else if(param2 == 116)
               {
                  _loc3_ = LanguageMgr.GetTranslation("store.view.compose.ComposeCellButton.3turn");
               }
               else if(param2 == 117)
               {
                  _loc3_ = LanguageMgr.GetTranslation("store.view.compose.ComposeCellButton.3wenzhang");
               }
               else
               {
                  _loc3_ = LanguageMgr.GetTranslation("store.view.compose.ComposeCellButton.suitGroup" + param2);
               }
               break;
            case 2:
               if(param2 == 3)
               {
                  _loc3_ = LanguageMgr.GetTranslation("store.view.compose.ComposeCellButton.jewel.title");
               }
               else if(param2 == 6)
               {
                  _loc3_ = LanguageMgr.GetTranslation("store.view.compose.ComposeCellButton.resis.title");
               }
               else if(param2 == 8)
               {
                  _loc3_ = LanguageMgr.GetTranslation("store.view.compose.ComposeCellButton.petJewel.title");
               }
               else if(param2 == 12)
               {
                  _loc3_ = LanguageMgr.GetTranslation("store.view.compose.ComposeCellButton.childJewel.title");
               }
               break;
            case 4:
               if(param2 == 16)
               {
                  _loc3_ = LanguageMgr.GetTranslation("store.view.compose.ComposeCellButton.avengerStone.title");
               }
               else if(param2 == 104)
               {
                  _loc3_ = LanguageMgr.GetTranslation("store.view.compose.ComposeCellButton.avengerGoldComposeStone.title");
               }
               else
               {
                  _loc3_ = LanguageMgr.GetTranslation("store.view.compose.ComposeCellButton.avengerPearl.title" + param2);
               }
               break;
            case 5:
               _loc3_ = LanguageMgr.GetTranslation("store.view.compose.ComposeCellButton.theseus.title" + param2);
               break;
            default:
               _loc3_ = "";
         }
         return _loc3_;
      }
      
      private function getJewelName(param1:int) : String
      {
         switch(param1 - 1)
         {
            case 0:
               return LanguageMgr.GetTranslation("public.jewel.Attack");
            case 1:
               return LanguageMgr.GetTranslation("public.jewel.Defence");
            case 2:
               return LanguageMgr.GetTranslation("public.jewel.MagicAttack");
            case 3:
               return LanguageMgr.GetTranslation("public.jewel.MagicDefence");
            case 4:
               return LanguageMgr.GetTranslation("public.jewel.ForceHit");
            case 5:
               return LanguageMgr.GetTranslation("public.jewel.Live");
            case 6:
               return LanguageMgr.GetTranslation("public.jewel.Conat");
            case 7:
               return LanguageMgr.GetTranslation("public.jewel.Parry");
            default:
               return "";
         }
      }
      
      override public function get selected() : Boolean
      {
         return _data && _data.selected;
      }
      
      override public function set selected(param1:Boolean) : void
      {
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
         _list = param1;
         selected = param2;
      }
      
      private function get canMakeCount() : String
      {
         if(!_data)
         {
            return "";
         }
         if(_data.canMakeCount <= 0)
         {
            return "";
         }
         return " (" + _data.canMakeCount + ")";
      }
      
      private function get model() : StoreModel
      {
         return FrameControllerManager.instance.storeController.model;
      }
      
      override public function dispose() : void
      {
         model.removeEventListener("COMPOSE_COMPLETE",__changeHandler);
         if(_data)
         {
            _data.removeEventListener("change",__changeHandler);
         }
         if(_icon)
         {
            _icon.dispose();
         }
         _icon = null;
         if(_numberTxt)
         {
            _numberTxt.dispose();
         }
         _numberTxt = null;
         super.dispose();
         _data = null;
      }
   }
}

