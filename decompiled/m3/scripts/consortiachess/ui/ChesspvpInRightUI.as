package consortiachess.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortiachess.item.ChesspvpInItem;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.ChessPvpManager;
   import mvc.module.chesspvp.ChessPvpModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.ConsortiaManager;
   
   public class ChesspvpInRightUI extends Sprite
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _tbg:ScaleLeftRightImage;
      
      protected var _intitleLine:MutipleImage;
      
      protected var _inRolePanle:ScrollPanel;
      
      protected var _inRoleVbox:VBox;
      
      protected var _inItemDic:Dictionary = new Dictionary();
      
      protected var _king:ChesspvpRoleNumUI;
      
      protected var _queen:ChesspvpRoleNumUI;
      
      protected var _bishop:ChesspvpRoleNumUI;
      
      protected var _knight:ChesspvpRoleNumUI;
      
      protected var _hook:ChesspvpRoleNumUI;
      
      protected var _pawn:ChesspvpRoleNumUI;
      
      protected var _inTcy:FilterFrameText;
      
      protected var _inTjob:FilterFrameText;
      
      protected var _inTlv:FilterFrameText;
      
      protected var _inTfight:FilterFrameText;
      
      protected var _inTrole:FilterFrameText;
      
      protected var _topTitlebg:Bitmap;
      
      protected var _topTitle:FilterFrameText;
      
      private var _leftwen:Bitmap;
      
      private var _rightwen:Bitmap;
      
      public function ChesspvpInRightUI()
      {
         super();
         initView();
         initData();
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inRightViewBg");
         _tbg = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inTitleBg");
         _intitleLine = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.intitleLine");
         _inRolePanle = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inRolePanle");
         _inRoleVbox = ComponentFactory.Instance.creatCustomObject("ui.chesspvp.inRoleVbox");
         _king = ComponentFactory.Instance.creatCustomObject("ui.chesspvp.king",[6]);
         _queen = ComponentFactory.Instance.creatCustomObject("ui.chesspvp.queen",[5]);
         _bishop = ComponentFactory.Instance.creatCustomObject("ui.chesspvp.bishop",[4]);
         _knight = ComponentFactory.Instance.creatCustomObject("ui.chesspvp.knight",[3]);
         _hook = ComponentFactory.Instance.creatCustomObject("ui.chesspvp.hook",[2]);
         _pawn = ComponentFactory.Instance.creatCustomObject("ui.chesspvp.pawn",[1]);
         _inTcy = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inTcy");
         _inTjob = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inTjob");
         _inTlv = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inTlv");
         _inTfight = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inTfight");
         _inTrole = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inTrole");
         _topTitlebg = ComponentFactory.Instance.creatBitmap("asset.chesspvp.in.title");
         _topTitle = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.in.topTitleTxt");
         _leftwen = ComponentFactory.Instance.creatBitmap("asset.chesspvp.leftFwen");
         _rightwen = ComponentFactory.Instance.creatBitmap("asset.chesspvp.rightFwen");
         addChild(_bg);
         addChild(_tbg);
         addChild(_intitleLine);
         addChild(_inRolePanle);
         addChild(_king);
         addChild(_queen);
         addChild(_bishop);
         addChild(_knight);
         addChild(_hook);
         addChild(_pawn);
         addChild(_inTcy);
         addChild(_inTjob);
         addChild(_inTlv);
         addChild(_inTfight);
         addChild(_inTrole);
         addChild(_topTitlebg);
         addChild(_topTitle);
         addChild(_leftwen);
         addChild(_rightwen);
         _inRolePanle.setView(_inRoleVbox);
         _topTitle.text = LanguageMgr.GetTranslation("chesspvp.in.topTitle");
         _inTcy.text = LanguageMgr.GetTranslation("chesspvp.in.tilte0");
         _inTjob.text = LanguageMgr.GetTranslation("chesspvp.in.tilte1");
         _inTlv.text = LanguageMgr.GetTranslation("chesspvp.in.tilte2");
         _inTfight.text = LanguageMgr.GetTranslation("chesspvp.in.tilte3");
         _inTrole.text = LanguageMgr.GetTranslation("chesspvp.in.tilte4");
         _topTitlebg.x = 0;
         _topTitlebg.y = -36;
         _topTitlebg.width = 605;
      }
      
      private function initData() : void
      {
         var _loc2_:ChesspvpInItem = null;
         var _loc8_:ThaneInfo = null;
         var _loc7_:int = 0;
         _inRoleVbox.beginChanges();
         _inRoleVbox.removeAllChild();
         var _loc3_:int = int(ArmyManager.instance.thane.userId);
         var _loc1_:ThaneInfo = ConsortiaManager.instance.getSimplePlayerInfoById(_loc3_);
         var _loc5_:Boolean = false;
         if(_loc1_.dutyId == 1)
         {
            _loc5_ = true;
         }
         var _loc6_:Array = memberList;
         if(_loc6_ != null)
         {
            _loc6_.sortOn("fightingCapacity",0x10 | 2);
         }
         var _loc4_:int = int(_loc6_ ? _loc6_.length : 0);
         _loc7_ = 0;
         while(_loc7_ < _loc4_)
         {
            _loc8_ = _loc6_[_loc7_];
            if(_loc8_ != null)
            {
               _loc2_ = _inItemDic[_loc8_.userId];
               if(_loc2_ == null)
               {
                  _loc2_ = new ChesspvpInItem(_loc5_);
                  _inItemDic[_loc8_.userId] = _loc2_;
               }
               _loc2_.initThane(_loc8_);
               _inRoleVbox.addChild(_loc2_);
            }
            _loc7_++;
         }
         _inRoleVbox.commitChanges();
         _inRolePanle.invalidateViewport();
      }
      
      public function onMemberListUpdata() : void
      {
         initData();
      }
      
      public function updateView() : void
      {
         var _loc1_:ChesspvpInItem = null;
         var _loc2_:int = 0;
         var _loc5_:Dictionary = model.chessTypeDic;
         var _loc3_:Dictionary = new Dictionary();
         for(var _loc4_:String in _loc5_)
         {
            _loc1_ = _inItemDic[_loc4_];
            _loc2_ = int(_loc5_[_loc4_]);
            if(_loc1_)
            {
               _loc1_.updateRole(_loc2_);
            }
            if(_loc3_[_loc2_] == null)
            {
               _loc3_[_loc2_] = 0;
            }
            _loc3_[_loc2_] += 1;
         }
         _king.updateProgress(int(_loc3_[6]));
         _queen.updateProgress(int(_loc3_[5]));
         _bishop.updateProgress(int(_loc3_[4]));
         _knight.updateProgress(int(_loc3_[3]));
         _hook.updateProgress(int(_loc3_[2]));
         _pawn.updateProgress(int(_loc3_[1]));
      }
      
      private function get model() : ChessPvpModel
      {
         return ChessPvpManager.Instance.model;
      }
      
      private function get memberList() : Array
      {
         return ConsortiaManager.instance.model.consortiaMemberList.getList();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_tbg);
         _tbg = null;
         ObjectUtils.disposeObject(_intitleLine);
         _intitleLine = null;
         ObjectUtils.disposeObject(_inRolePanle);
         _inRolePanle = null;
         ObjectUtils.disposeObject(_inRoleVbox);
         _inRoleVbox = null;
         ObjectUtils.disposeObject(_king);
         _king = null;
         ObjectUtils.disposeObject(_queen);
         _queen = null;
         ObjectUtils.disposeObject(_bishop);
         _bishop = null;
         ObjectUtils.disposeObject(_knight);
         _knight = null;
         ObjectUtils.disposeObject(_hook);
         _hook = null;
         ObjectUtils.disposeObject(_pawn);
         _pawn = null;
         ObjectUtils.disposeObject(_inTcy);
         _inTcy = null;
         ObjectUtils.disposeObject(_inTjob);
         _inTjob = null;
         ObjectUtils.disposeObject(_inTlv);
         _inTlv = null;
         ObjectUtils.disposeObject(_inTfight);
         _inTfight = null;
         ObjectUtils.disposeObject(_inTrole);
         _inTrole = null;
         ObjectUtils.disposeObject(_topTitlebg);
         _topTitlebg = null;
         ObjectUtils.disposeObject(_topTitle);
         _topTitle = null;
         ObjectUtils.disposeObject(_leftwen);
         _leftwen = null;
         ObjectUtils.disposeObject(_rightwen);
         _rightwen = null;
         for each(var _loc1_:ChesspvpInItem in _inItemDic)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _inItemDic = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

